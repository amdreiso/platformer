

if (keyboard_check_pressed(vk_anykey)) {
	if (keyboard_lastkey == 27) {
		active = !active;
	}
}

if (Keymap.pause) {
	active = !active;
}

// boolean active = 0 - 1
alpha = lerp(alpha, active, 0.1);

if (active) {
	menuPosX = lerp(menuPosX, menuPosXFinal, 0.1);
} else {
	menuPosX = lerp(menuPosX, -menuWidth * 3, 0.1);	
}

