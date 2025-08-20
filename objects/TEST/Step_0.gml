
if (!keyboard_check_pressed(vk_f1)) return;


language_set(LANGUAGE_ID.Brazilian);

Debug.debug = true;


room_goto(rmLevel_Cave_DumpYard);

camera_set_zoom(2);
player_set_position(vec2(600, 300));

