
isSolid = false;

// Data
item_data();
command_data();


// Init functions
randomize();
load_enums();
load_macros();
textbox();
fovy();

item_init();


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
globalvar Debug; Debug = true;

globalvar Settings; Settings = {
	graphics: {
		maxParticlesOnScreen: 200,
		cameraShakeIntensity: 1.0,
		guiScale: 2.0,
		raycastCount: 500,
		showKey: true,
	},
	
	audio: {
	},
};

globalvar Keymap; Keymap = keymap_get();
globalvar ScreenFlash; ScreenFlash = {
	alpha: 0,
	color: c_white,
	time: 0.1,
	
	flash: function() {
		print("flashing screen");
	},
};

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
};
draw_set_font(fnt_main);

globalvar Gravity; Gravity = 0.1;
globalvar Console; Console = false;

globalvar Sound; Sound = {};

var m = 1;
Sound.distance = 300 * m;
Sound.dropoff	= 100 * m;
Sound.multiplier = 0.2;

audio_falloff_set_model(audio_falloff_exponent_distance);
audio_listener_orientation(0, 1, 0, 0, 0, 1);


rainbowTick = 0;
rainbowSpeed = 1;
rainbowSaturation = 220;
rainbowValue = 220;


if (!instance_exists(Player)) {
	instance_create_layer(190, 500, "Init", Player);
}

room_goto(rmLevel_CaveEntrance);



// Room transition
transition = false;
transitionTime = 0.1;
transitionColor = c_black;
transitionAlpha = 0;
transitionOutput = -1;
transitionPlayerPosition = vec2();
transitionOnEnter = function(){}



// Console
logs = [];
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
				log($"Missing arguments.");
				return;
			}
			
			CommandData[i].fn(args);
			found = true;
		}
	}
	
	if (!found) {
		log("Invalid command!");
	}
}

drawConsole = function() {
	if (!Console) return;
	
	var input = keyboard_string;
	
	if (keyboard_check_pressed(vk_enter)) {
		runCommand(input, true);
		keyboard_string = "";
	}
	
	// Draw the actual console
	var width = 700;
	var height = 400;
	var c0 = $080808;
	var c1 = c_gray;
	
	draw_set_alpha(0.95);
	
	draw_rectangle_color(
		window_get_width() - width, 200, window_get_width(), 200 + height, 
		c0, c0, c0, c0, false
	);
	
	draw_set_alpha(1);
	
	draw_rectangle_color(
		window_get_width() - width, 200, window_get_width(), 200 + height, 
		c1, c1, c1, c1, true
	);
	
	draw_set_halign(fa_left);
	
	// Draw logs
	for (var i = 0; i < array_length(logs); i++) {
		var sep = 14;
	
		draw_set_font(logs[i].font);
		
		draw_text_color(window_get_width() - width + 5, (150 + height) - i * sep, logs[i].str, logs[i].color, logs[i].color, logs[i].color, logs[i].color, 1);
	}
	
	draw_set_font(fnt_console);
		
	draw_text(window_get_width() - width + 5, 180 + height, "> " + input);
	
	draw_set_font(fnt_main);
	draw_set_halign(fa_center);
	
	var scale = 0.10;
	var yy = 201;
	
	// KITTIESSSS
	draw_sprite_ext(sKitty, 0, window_get_width(), yy + height, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sKitty3, 0, window_get_width() - (sprite_get_width(sKitty) * scale), yy + height, scale, scale, 0, c_white, 1);
	draw_sprite_ext(sKitty2, 0, window_get_width() - (sprite_get_width(sKitty3) * scale), yy + height, scale, scale, 0, c_white, 1);
}

runCommand("start");

