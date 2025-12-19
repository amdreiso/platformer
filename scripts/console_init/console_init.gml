
function console_init() {
	
	globalvar CONSOLE;
	CONSOLE = {
		logs : [],
		commands : [],
		logRewind	: -1,
		scroll : 0,
		scrollSpeed	: 3,
		pos : new Vec2(1, 1),
	};
	
	CONSOLE.Run = function(input, showHistory = false) {
		if (input == "") return;
	
		var args = string_split(input, " ", true);
		var command = args[0];
		array_delete(args, 0, 1);
	
		var found = false;
	
		if (showHistory)
			log("- "+input);
	
		// Run Actual Command
		for (var i = 0; i < array_length(CommandData); i++) {
			if (string_lower(command) == CommandData[i].name) {
				var argc = CommandData[i].argc;
				var argl = array_length(args);
			
				if (argc != argl && argc != -1) {
					err($"Missing {argc} arguments.");
					return;
				}
			
				CommandData[i].fn(args);
				found = true;
			}
		}
	
		for (var obj = 0; obj < instance_count; obj++) {
			if (string_starts_with(command, object_get_name(obj))) {
				var str = command;
				var slices = string_split(str, ".");
				var arguments = string_split(str, "=");
			
				if (array_length(slices) < 2) {
					err("Usage is 'Object.variable=value'");
					found = true;
					break;
				}
			
				var arglen = array_length(arguments);
				if (arglen < 2) {
				
					var asset = asset_get_index(slices[0]);
			
					var sliceofslice = string_split(slices[1], "=");
					var name = sliceofslice[0];
				
					if (object_exists(asset)) log( struct_get(asset, name) );
				
					found = true;
					break;
				}
			
				var value = arguments[1];
				var asset = asset_get_index(slices[0]);
			
				var sliceofslice = string_split(slices[1], "=");
				var name = sliceofslice[0];
			
				log($"{asset}.{name} set to {value}");
			
				var variable = variable_struct_get(asset, name);
				log(typeof(variable));
			
				switch (typeof(variable)) {
					case "number":
						variable_struct_set(asset, name, real(value));
						break;
						
					case "int64":
						variable_struct_set(asset, name, real(value));
						break;
				
					case "string":
						variable_struct_set(asset, name, value);
						break;
				
					case "bool":
						var b = false;
						if (value == "true" || value == "1") b = true;
						if (value == "false" || value == "0") b = false;


						variable_struct_set(asset, name, b);
						break;
				
					case "struct":
						// do nothing
						break;
				}
			
				found = true;
			}
		}
	
		if (!found) {
			err("Invalid command!");
		}
	}
	
	CONSOLE.Clear = function() {
		CONSOLE.scroll = 0;
		CONSOLE.commands = [];
		CONSOLE.logs = [];
	}
	
	CONSOLE.Draw = function() {
		if (!Debug.console) return;
	
		var input = keyboard_string;
		static pastCommand = 0;
	
		if (keyboard_check_pressed(vk_enter)) {
			CONSOLE.Run(input, true);
			array_push(CONSOLE.commands, input);
			keyboard_string = "";
			pastCommand = 0;
		}
	
		if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) && clipboard_has_text()) {
			keyboard_string += clipboard_get_text();
		}
	
		if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C")) && keyboard_string != "") {
			clipboard_set_text(keyboard_string);
		}
	
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_backspace)) {
			var s = keyboard_string;
	    var specials = ".=/ ";
	    var found = false;
		
	    for (var i = string_length(s); i > 0; --i) {
	      var ch = string_char_at(s, i);
	      if (string_pos(ch, specials) > 0) {
	        keyboard_string = string_copy(s, 1, i);
	        found = true;
	        break;
	      }
	    }
    
			if (!found) keyboard_string = "";
		}
	
		if (keyboard_check_pressed(vk_tab)) {
			var partial = string_lower(input);
			var matches = [];
	
			for (var i = 0; i < array_length(CommandData); i++) {
				var cmd_name = string_lower(CommandData[i].name);
				if (string_pos(partial, cmd_name) == 1) {
					array_push(matches, CommandData[i].name);
				}
			}
		
			if (array_length(matches) == 1) {
				keyboard_string = matches[0] + " ";
			}
		
			else if (array_length(matches) > 1) {
				for (var i = 0; i < array_length(matches); i++) {
					log(matches[i], c_ltgray);
				}
				log("");
			}
		}
	
	
		var len = array_length(CONSOLE.commands);
	
		if (keyboard_check_pressed(vk_up) && pastCommand < len) {
			pastCommand += 1;
			keyboard_string = CONSOLE.commands[len - pastCommand];
		}
	
		if (keyboard_check_pressed(vk_down) && pastCommand > 1) {
			pastCommand -= 1;
			keyboard_string = CONSOLE.commands[len - pastCommand];
		}
	
		// Draw the actual console
		var width = 800;
		var height = 412;
		var xx = CONSOLE.pos.x;
		var yy = HEIGHT - height - 4;
		var c0 = $080808;
		var c1 = Style.rainbow;
	
		draw_set_alpha(0.95);
	
		draw_rectangle_color(
			xx, yy, xx + width, yy + height, 
			c0, c0, c0, c0, false
		);
	
		draw_set_alpha(1);
	
		draw_rectangle_color(
			xx, yy, xx + width, yy + height, 
			c1, c1, c1, c1, true
		);
	
		draw_set_halign(fa_left);
	
		// Draw logs
		var count = array_length(CONSOLE.logs);
		var maxcount = 26;
		if (array_length(CONSOLE.logs) > maxcount) {
			count = maxcount;
		}
	
		CONSOLE.scroll += (mouse_wheel_up() && CONSOLE.scroll < array_length(CONSOLE.logs) - maxcount - CONSOLE.scrollSpeed) ? CONSOLE.scrollSpeed : 0;
		CONSOLE.scroll -= (mouse_wheel_down() && CONSOLE.scroll > 0) ? CONSOLE.scrollSpeed : 0;
	
		for (var i = CONSOLE.scroll; i < count + CONSOLE.scroll; i++) {
			var sep = 14;
	
			draw_set_font(CONSOLE.logs[i].font);
		
			var yo = 50;
			
			draw_text_color(
				xx + 5, 
				(yy - yo + height) - (i - CONSOLE.scroll) * sep, 
			
				CONSOLE.logs[i].str, 
				CONSOLE.logs[i].color, CONSOLE.logs[i].color, CONSOLE.logs[i].color, CONSOLE.logs[i].color, 1
			);
		}
	
		draw_set_font(fnt_console);
		
		var bar = "█";
		draw_text(xx + 5, yy - 20 + height, "> " + input + bar);
	
		draw_set_font(fnt_console);
	
		var scale = 0.10;
		var yyy = yy + 1;
	
		// KITTIESSSS
		draw_sprite_ext(sKitty, 0, xx + width, yyy + height, scale, scale, 0, c_white, 1);
		draw_sprite_ext(sKitty3, 0, xx + width - (sprite_get_width(sKitty) * scale), yyy + height, scale, scale, 0, c_white, 1);
		draw_sprite_ext(sKitty2, 0, xx + width - (sprite_get_width(sKitty3) * scale), yyy + height, scale, scale, 0, c_white, 1);
		
		
		// Move console window
		//if (mouse_collision("top left", xx, yy, width, height)) {
		//	if (mouse_check_button(mb_left)) {
		//		CONSOLE.pos.x = (window_mouse_get_x() - width / 2);
		//		CONSOLE.pos.y = (window_mouse_get_y() - height / 2);
		//	}
		//}
	}
}

function log(str, color = c_ltgray, font = fnt_console) {
	if (!instance_exists(Main)) return;
	
	var slices = string_split(str, "\n");
	
	for (var i = 0; i < array_length(slices); i++) {
		array_insert(CONSOLE.logs, 0, {
			str: slices[i],
			color: color,
			font: font,
		});
	}
}

function err(str) {
	if (!instance_exists(Main)) return;
	
	array_insert(CONSOLE.logs, 0, {
		str: "err: "+str,
		color: c_red,
		font: fnt_console_bold,
	});
}
