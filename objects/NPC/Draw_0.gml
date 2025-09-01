
if (sprite_index == -1) return;

if (talking) {
	sprite_index = talkingSprite;
} else {
	sprite_index = idleSprite;
}

draw_self();

reach = (point_distance_3d(x, y, 0, Player.x, Player.y, 0) < sprite_width * 1.5);

if (reach && array_length(dialogue) > 0 && !Player.busy && !OnCutscene) {
	
	//if !(talking) draw_key(sButton_E);
	
	if (Keymap.player.interact && !instance_exists(Textbox)) {
		var txt = instance_create_depth(x + offset.x, y + offset.y, depth, Textbox);
		txt.dialogue = dialogue;
		txt.dialogueEnd = dialogueEnd;
		txt.npc = self;
		
		talking = true;
		
		camera_focus(self);
		camera_set_zoom(0.8);
	}
	
	draw_outline(1, 0, Style.outlineColor);
}

if (talking && !instance_exists(Textbox)) {
	talking = false;
}


