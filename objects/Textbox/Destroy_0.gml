
dialogueEnd(npc);

Level.screenlog("Textbox: destroyed Textbox");

if (npc == noone) return;

camera_focus(Player);
camera_set_zoom(CAMERA_ZOOM_DEFAULT);

