
x += hsp;
y += vsp;

if (keyboard_check_pressed(ord("T"))) sleep(20);


if (!keyboard_check_pressed(vk_f1)) return;


language_set(LANGUAGE_ID.English);

Debug.debug = true;

room_goto(rmLevel_Cave_DumpYard);
Level.newRoom = true;

camera_set_zoom(2);
player_set_position(new Vec2(492, 400));

