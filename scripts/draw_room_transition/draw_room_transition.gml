function draw_room_transition(){
	var c = transitionColor;
	
	draw_set_alpha(transitionAlpha);
	draw_rectangle_color(0, 0, WIDTH, HEIGHT, c, c, c, c, false);
	draw_set_alpha(1);
	
	if (transition) {
		
		if (transitionAlpha < 1) {
			transitionAlpha += transitionTime;
		} else {
			
			room_goto(transitionOutput);
			player_set_position(transitionPlayerPosition);
			transitionOnEnter();
			
		}
		
	} else if (!transition) {
		
		if (transitionAlpha > 0) {
			transitionAlpha -= transitionTime;
		} else {}
		
	}
	
	
	
}