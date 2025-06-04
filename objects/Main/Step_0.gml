

Keymap = keymap_get();


// Rainbow
Style.rainbow = make_color_hsv(floor(rainbowTick), rainbowSaturation, rainbowValue);

rainbowTick += rainbowSpeed;
if (rainbowTick >= 255) rainbowTick = 0;


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
	
	if (keyboard_check_pressed(ord("C"))) {
		object_set_visible(Collision, true);
		object_set_visible(Collision_Slope, true);
	}
	
	if (keyboard_check_pressed(ord("F"))) {
		ScreenFlash.flash();
	}
}

if (keyboard_check_pressed(vk_f3)) {
	Debug = !Debug;
}

if (keyboard_check_pressed(vk_rcontrol)) {
	Console = !Console;
	keyboard_string = "";
}
