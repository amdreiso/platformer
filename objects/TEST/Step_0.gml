
x += hsp;
y += vsp;

if (keyboard_check_pressed(ord("T"))) then sleep(20);

if (keyboard_check_pressed(vk_f1)) {
	CONSOLE.Run("player_add_all");
	room_goto(rmLevel_Cave_Elevator);
}

if (keyboard_check_pressed(vk_f2)) {
	SaveManager.Restore();
	game_restart();
}
