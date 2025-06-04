function draw_key(sprite){
	if (Settings.graphics.showKey) {
		var size = 3;
		var offset = sin(current_time * 0.005) * (sprite_get_height(sprite) * size) / 5;
		draw_sprite_ext(
			sprite, 0, WIDTH-50, HEIGHT-50 + offset, 
			size, size, 0, c_white, 1
		);
	}
}