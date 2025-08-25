
enum KEY_INDICATOR {
	Interact,
	InteractDoor,
}

function draw_key(indicator){
	
	var kb = sButton_E;					// keyboard
	var gp = sButton_Circle;		// gamepad
	
	switch (indicator) {
		case KEY_INDICATOR.Interact:
			kb = sButton_C;
			gp = sButton_Circle;
			break;
		
		case KEY_INDICATOR.InteractDoor:
			kb = sButton_UP_keyboard;
			gp = sButton_UP;
			break;
		
	}
	
	
	var spr = kb;
	if (CurrentController == CONTROLLER_INPUT.Gamepad) spr = gp;
	
	var scale = 3;
	var margin = 15 * scale;
	var xx = WIDTH - margin;
	var yy = HEIGHT - margin;
	
	draw_sprite_ext(spr, 0, xx, yy, scale, scale, 0, c_white, 1);
	
}