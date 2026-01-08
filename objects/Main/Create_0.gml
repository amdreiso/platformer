

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
achievement_init();


// Save manager init
save_manager();



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

globalvar Occasion; Occasion = {
	christmas : false,
	easter : false,
	halloween : false,
}


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
console_init();

// TODO:
// Fix this
// instead of using array, use map for CommandData
// way better to set keys for the commands to not flood the array with the same commands

CONSOLE.Run("start");


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


globalvar COLOR;
COLOR = {
	Purple : new Color(0.6, 0.2, 0.9),
	Red : new Color(1.0, 0.0, 0.0),
	Green : new Color(0.0, 1.0, 0.0),
	Blue : new Color(0.0, 0.0, 1.0),
	Yellow : new Color(1.0, 1.0, 0.0),
	White : new Color(1.0, 1.0, 1.0),
};


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




