function draw_room_transition(){
	var c = transitionColor;
	
	draw_set_alpha(transitionAlpha);
	draw_rectangle_color(0, 0, WIDTH, HEIGHT, c, c, c, c, false);
	draw_set_alpha(1);
	
	if (transition) {
		
		if (transitionAlpha < 1) {
			
			transitionAlpha += transitionTime;
			
		} else {
			
			transitionCooldown ++;
			
			var pos = transitionPlayerPosition;
			var newPos = vec2(
				pos.x,
				pos.y + sprite_get_height(Player.sprite_index) / 2
			);
			
			if (transitionCooldown > transitionCooldownTime) {
				room_goto(transitionOutput);
				
				Level.newRoom = true;
				Player.lastPlaceStanding = Player.getLastStandingPosition();
				
				transition = false;
			}
			
			//audio_stop_sound(Level.backgroundSong);
			
		}
		
	} else if (!transition) {
		
		transitionCooldown = 0;
		
		if (transitionAlpha > 0) {
			
			transitionAlpha -= transitionTime;
			
		} else {}
		
	}
	
}