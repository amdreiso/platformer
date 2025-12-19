
enum KEY_INDICATOR {
	Interact,
	InteractDoor,
	Down,
	Up,
}

function draw_key(indicator, pos = new Vec2(), scale = 3){
	
	var kb = sButton_E;					// keyboard
	var gp = sButton_Circle;		// gamepad
	
	switch (indicator) {
		case KEY_INDICATOR.Interact:
			kb = sButton_UP_keyboard;
			gp = sButton_Circle;
			break;
		
		case KEY_INDICATOR.InteractDoor:
			//kb = sButton_UP_keyboard;
			//gp = sButton_UP;
			kb = sButton_UP_keyboard;
			gp = sButton_Circle;
			break;
		
		case KEY_INDICATOR.Down:
			kb = sButton_DOWN_keyboard;
			gp = sButton_DOWN;
			break;
		
		case KEY_INDICATOR.Up:
			kb = sButton_UP_keyboard;
			gp = sButton_UP;
			break;
		
	}
	
	var spr = kb;
	if (CurrentController == CONTROLLER_INPUT.Gamepad) spr = gp;
	
	var margin = 15 * scale;
	var xx = WIDTH - margin;
	var yy = HEIGHT - margin;
	
	if (pos.x != 0 || pos.y != 0) {
		xx = pos.x;
		yy = pos.y;
	}
	
	draw_sprite_ext(spr, 0, xx, yy, scale, scale, 0, c_white, 1);
	
}