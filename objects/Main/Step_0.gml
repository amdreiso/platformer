

Gravity = 0.07;


#region Globals

Keymap = keymap_get();
OnCutscene = instance_exists(Cutscene);

if (Gamepad.ID == -1 && current_time < 1000) gamepad_find();

if (instance_exists(PauseMenu)) {
	Paused = PauseMenu.active;
}

#endregion


#region Layers

layer_set_visible(layer_get_id("Collisions"), Debug.debug);

#endregion


#region Sound

// Set volume for audiogroups
audio_group_set_gain(audiogroup_songs, Settings.audio.volume * Settings.audio.music, 1);

#endregion


#region Style

// Rainbow
Style.rainbow = make_color_hsv(floor(rainbowTick), rainbowSaturation, rainbowValue);

rainbowTick += rainbowSpeed;
if (rainbowTick >= 255) rainbowTick = 0;

// No idea what this is supposed to be.
Style.reverseIntensity = sin(current_time * 0.001) * 1;

#endregion


#region Settings


if (Gamepad.ID != -1) {
	gamepad_set_axis_deadzone(Gamepad.ID, Settings.controls.gamepadDeadzone);
	
}


#endregion


#region Controller

if (keyboard_check_pressed(vk_anykey) && CurrentController != CONTROLLER_INPUT.Keyboard) {
	print("Controller set to KEYBOARD");
	CurrentController = CONTROLLER_INPUT.Keyboard;
}

if (gp_anykey() && CurrentController != CONTROLLER_INPUT.Gamepad) {
	print("Controller set to GAMEPAD");
	CurrentController = CONTROLLER_INPUT.Gamepad;
}

#endregion


#region Menus




#endregion


#region Hotkeys

if (keyboard_check(vk_alt)) {
	if (keyboard_check(ord("R"))) {
		if (keyboard_check(vk_down)) {
			Settings.graphics.raycastCount -= 1;
		}
		if (keyboard_check(vk_up)) {
			Settings.graphics.raycastCount += 1;
		}
	}
	
	if (keyboard_check(ord("L"))) {
		if (keyboard_check(vk_down)) {
			Level.darkness -= 0.001;
		}
		if (keyboard_check(vk_up)) {
			Level.darkness += 0.001;
		}
	}
}

if (keyboard_check(vk_control)) {
	if (keyboard_check_pressed(ord("R"))) {
		game_restart();
	}
	
	if (keyboard_check_pressed(ord("F"))) {
		ScreenFlash.flash();
	}
	
	if (keyboard_check_pressed(ord("S"))) {
		save_room_screenshot();
	}
}


// Debug
if (keyboard_check_pressed(vk_f3)) {
	Debug.debug = !Debug.debug;
	
	if (keyboard_check(ord("A"))) {
		Debug.drawAttackCommandInput = !Debug.drawAttackCommandInput;
	}
}

if (keyboard_check_pressed(vk_anykey)) {
	if (keyboard_lastkey != 192) return;			// apostrophe
	
	Debug.console = !Debug.console;
	keyboard_string = "";
}


#endregion


