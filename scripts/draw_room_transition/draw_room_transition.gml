function draw_room_transition(){
	var c = transitionColor;
	
	draw_set_alpha(transitionAlpha);
	draw_rectangle_color(0, 0, WIDTH, HEIGHT, c, c, c, c, false);
	draw_set_alpha(1);
	
	if (transition) {
		
		if (transitionAlpha < 1) {
			
			transitionAlpha += transitionTime;
			
		} else {
			
			var pos = transitionPlayerPosition;
			var newPos = vec2(
				pos.x,
				pos.y + sprite_get_height(Player.sprite_index) / 2
			);
			
			room_goto(transitionOutput);
			
			transitionOnEnter();
			
			transition = false;
			
			//audio_stop_sound(Level.backgroundSong);
			
		}
		
	} else if (!transition) {
		
		if (transitionAlpha > 0) {
			transitionAlpha -= transitionTime;
		} else {}
		
	}
	
}