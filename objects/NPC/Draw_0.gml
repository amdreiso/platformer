
if (sprite_index == -1) return;

if (talking) {
	sprite_index = talkingSprite;
} else {
	sprite_index = idleSprite;
}

draw_self();

if (place_meeting(x, y, Player)) {
	
	if !talking draw_key(sButton_E);
	
	if (keyboard_check_pressed(ord("E")) && !instance_exists(Textbox)) {
		var txt = instance_create_depth(x + offset.x, y + offset.y, depth, Textbox);
		txt.dialogue = dialogue;
		txt.text = parse_rich_text(txt.dialogue[0]);
		txt.npc = self;
		
		talking = true;
		
		camera_focus(self, 0.8);
	}
	
	draw_outline(1, 0, Style.outlineColor);
}

if (talking && !instance_exists(Textbox)) {
	talking = false;
}


