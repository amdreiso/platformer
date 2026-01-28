
x += hsp;
y += vsp;

if (keyboard_check_pressed(vk_f1)) {
}

if (keyboard_check_pressed(vk_f2)) {
	SaveManager.Restore();
	game_restart();
}
