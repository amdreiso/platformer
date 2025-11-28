

// Init functions
randomize();
enums_load();
macros_load();
textbox_load();
fovy();

translation_init();
item_init();
level_init();
command_init();
effect_init();
spell_init();
cutscene_init();


// Story
story_progression();




// Game info
globalvar GameInfo;
GameInfo = {
	name: "unnamed robot game",
	version: [0, 0],
	build: "indev",
	author: "amdrei",
}


// Globals
globalvar Paused; Paused = false;
globalvar GameSpeed; GameSpeed = 1;

globalvar Debug; Debug = {
	debug: false,
	tools: false,
	console: false,
	specs: false,
	drawAttackCommandInput: false,
};

globalvar Sleep; Sleep = 0;

globalvar Settings; Settings = settings_get();
settings_load();

globalvar Language; Language = LANGUAGE_ID.English;
globalvar LanguageReset; LanguageReset = true;

globalvar Keymap;

globalvar OnCutscene; OnCutscene = false;

globalvar Seed; Seed = irandom_range(2000, 2000000);
globalvar Style; Style = {
	backgroundColor: $ff080808,
	outlineColor: make_color_rgb(255, 162, 172),
	iconColor: c_ltgray,
	iconColorSelected: $ff181818,
	rainbow: $ff,
	textColor: $fffcfcfc,
	marginGUI: 10,
	guiScale: 3,
	palette: -1,
	reverseColors: false,
	reverseIntensity: 0,
	
	sliderBackground: $FF080808,
	
	GUI: {
		dark: {
			buttonBackground: $FF181818,
			buttonForeground: c_white,
		},
		
		light: {
			buttonBackground: 0xdddddd,
			buttonForeground: $FF181818,
		}
	},
};
draw_set_font(fnt_console);

globalvar Gravity; Gravity = 0.07;
globalvar Console; Console = false;

enum CONTROLLER_INPUT {
	Keyboard,
	Gamepad,
}

globalvar CurrentController; CurrentController = CONTROLLER_INPUT.Keyboard;
globalvar Gamepad;
gamepad_init();


// Camera
globalvar CameraViewport; CameraViewport = CAMERA_VIEWPORT_DEFAULT;


screenFlashColor = c_white;
screenFlashDecrement = 0.1;
screenFlashTime = 0;

globalvar Screen; Screen = {
	flash: function(time, decrement, color = c_white) {
		Main.screenFlashColor = color;
		Main.screenFlashDecrement = decrement;
		Main.screenFlashTime = time;
	}
};


callback = new Callback();


// Sound
globalvar Sound; Sound = {};

var m = 1;
Sound.distance = 300 * m;
Sound.dropoff	= 100 * m;
Sound.multiplier = 0.2;

audio_falloff_set_model(audio_falloff_exponent_distance);
audio_listener_orientation(0, 1, 0, 0, 0, 1);

audio_group_load(audiogroup_default);
audio_group_load(audiogroup_songs);


rainbowTick = 0;
rainbowSpeed = 1;
rainbowSaturation = 220;
rainbowValue = 220;




// Room transition
transition = false;
transitionTime = 0.01;
transitionColor = c_black;
transitionAlpha = 0;
transitionOutput = -1;
transitionPlayerPosition = new Vec2();
transitionPlayerOffset = new Vec2();
transitionOnEnter = function(){}
transitionSide = "side";
transitionCooldown = 0;
transitionCooldownTime = 0;



// console
logs = [];
commands = [];
logRewind = -1;

// TODO:
// Fix this
// instead of using array, use map for CommandData
// way better to set keys for the commands to not flood the array with the same commands

runCommand = function(input, showHistory = false) {
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
				err("Usage is 'Object.variable = value'");
				found = true;
				break;
			}
			
			var arglen = array_length(arguments);
			if (arglen < 2) {
				err("Not enough arguments!");
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
				
				case "string":
					variable_struct_set(asset, name, value);
					break;
			}
			
			found = true;
		}
	}
	
	if (!found) {
		err("Invalid command!");
	}
}

consoleScroll = 0;
consoleScrollSpeed = 3;

clearConsole = function() {
	consoleScroll = 0;
	commands = [];
	logs = [];
}

drawConsole = function() {
	if (!Debug.console) return;
	
	var input = keyboard_string;
	static pastCommand = 0;
	
	if (keyboard_check_pressed(vk_enter)) {
		runCommand(input, true);
		array_push(commands, input);
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
	
	
	var len = array_length(commands);
	
	if (keyboard_check_pressed(vk_up) && pastCommand < len) {
		pastCommand += 1;
		keyboard_string = commands[len - pastCommand];
	}
	
	if (keyboard_check_pressed(vk_down) && pastCommand > 1) {
		pastCommand -= 1;
		keyboard_string = commands[len - pastCommand];
	}
	
	// Draw the actual console
	var width = 700;
	var height = 412;
	var xx = width * 1.05;
	var yy = 0;
	var c0 = $080808;
	var c1 = Style.rainbow;
	
	draw_set_alpha(0.95);
	
	draw_rectangle_color(
		xx - width, 200, xx, 200 + height, 
		c0, c0, c0, c0, false
	);
	
	draw_set_alpha(1);
	
	draw_rectangle_color(
		xx - width, 200, xx, 200 + height, 
		c1, c1, c1, c1, true
	);
	
	draw_set_halign(fa_left);
	
	// Draw logs
	var count = array_length(logs);
	var maxcount = 26;
	if (array_length(logs) > maxcount) {
		count = maxcount;
	}
	
	consoleScroll += (mouse_wheel_up() && consoleScroll < array_length(logs) - maxcount - consoleScrollSpeed) ? consoleScrollSpeed : 0;
	consoleScroll -= (mouse_wheel_down() && consoleScroll > 0) ? consoleScrollSpeed : 0;
	
	for (var i = consoleScroll; i < count + consoleScroll; i++) {
		var sep = 14;
	
		draw_set_font(logs[i].font);
		
		draw_text_color(
			xx - width + 5, 
			(150 + height) - (i - consoleScroll) * sep, 
			
			logs[i].str, 
			logs[i].color, logs[i].color, logs[i].color, logs[i].color, 1
		);
	}
	
	draw_set_font(fnt_console);
		
	var bar = "█";
	draw_text(xx - width + 5, 180 + height, "> " + input + bar);
	
	draw_set_font(fnt_console);
	
	var scale = 0.10;
	var yyy = 201;
	
	// KITTIESSSS
	draw_sprite_ext(sKitty, 0, xx, yyy + height, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sKitty3, 0, xx - (sprite_get_width(sKitty) * scale), yyy + height, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sKitty2, 0, xx - (sprite_get_width(sKitty3) * scale), yyy + height, scale, scale, 0, c_white, 1);
}

runCommand("start");


// For testing snippets of code
instance_create_depth(0, 0, -999999, TEST);


//// Mod loader
//modloader = {};

//modloader.load = function() {
//	if (!directory_exists("mods")) return false;

//	var pattern = "mods/*.*";
//	var file = file_find_first(pattern, fa_archive);

//	while (file != "") {
//		if (string_ends_with(file, ".hhl")) {
//			// Interpret this file
//			interpreter_load("mods/"+file);
//		}
	
//	  file = file_find_next();
//	}

//	file_find_close();
//}

//modloader.load();




if (!instance_exists(Player)) {
	instance_create_layer(190, 232, "Init", Player);
	//instance_create_layer(600, 300, "Init", Player);
}

if (!instance_exists(TEST)) {
	instance_create_layer(190, 232, "Init", TEST);
	//instance_create_layer(600, 300, "Init", Player);
}

if (!instance_exists(Level)) {
	instance_create_layer(0, 0, "Init", Level);
	//instance_create_layer(600, 300, "Init", Player);
}

if (!instance_exists(QuestHandler)) {
	instance_create_layer(190, 500, "Init", QuestHandler);
}

if (!instance_exists(PauseMenu)) {
	instance_create_layer(0, 0, "Init", PauseMenu);
}




