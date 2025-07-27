
isSolid = false;

// Data
//item_data();
//command_data();
//level_data();
//translation_data();


// Init functions
randomize();
enums_load();
macros_load();
textbox_load();
fovy();

item_init();
level_init();
//directories_init();
translation_init();
command_init();


// Story
story_progression();


// Game info
globalvar GameInfo;
GameInfo = {
	name: "wall-e my beloved",
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
};


globalvar Settings; Settings = {
	graphics: {
		maxParticlesOnScreen: 200,
		cameraShakeIntensity: 1.0,
		guiScale: 2.0,
		raycastCount: 500,
		showKey: true,
	},
	
	audio: {
		volume: 1,
		music: 1,
		sfx: 1,
	},
	
	controls: {
		gamepadDeadzone: 0.25,
	}
};


globalvar Language; Language = LANGUAGE_ID.Brazilian;
globalvar ChangeLanguage; ChangeLanguage = true;

globalvar Keymap;

globalvar ScreenFlash; ScreenFlash = {
	alpha: 0,
	color: c_white,
	time: 0.1,
	
	flash: function() {
		print("flashing screen");
	},
};

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
};
draw_set_font(fnt_main);

globalvar Gravity; Gravity = 0.1;
globalvar Console; Console = false;

enum CONTROLLER_INPUT {
	Keyboard,
	Gamepad,
}

globalvar CurrentController; CurrentController = CONTROLLER_INPUT.Keyboard;
globalvar Gamepad;
gamepad_init();



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


if (!instance_exists(Player)) {
	instance_create_layer(190, 500, "Init", Player);
}

if (!instance_exists(QuestHandler)) {
	instance_create_layer(190, 500, "Init", QuestHandler);
}


room_goto(rmLevel_Cave_Entrance);



// Room transition
transition = false;
transitionTime = 0.1;
transitionColor = c_black;
transitionAlpha = 0;
transitionOutput = -1;
transitionPlayerPosition = vec2();
transitionOnEnter = function(){}



// console
logs = [];
commands = [];
logRewind = -1;

runCommand = function(input, showHistory = false) {
	if (input == "") return;
	
	var args = string_split(input, " ", true);
	array_delete(args, 0, 1);
	
	var found = false;
	
	if (showHistory)
		log("- "+input);
	
	// Run Actual Command
	for (var i = 0; i < array_length(CommandData); i++) {
		if (string_starts_with(string_lower(input), CommandData[i].name)) {
			var argc = CommandData[i].argc;
			var argl = array_length(args);
			
			if (argc != argl) {
				err($"Missing {argc} arguments.");
				return;
			}
			
			CommandData[i].fn(args);
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
	var xx = window_get_width();
	var yy = display_get_height();
	var width = 700;
	var height = 400;
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






