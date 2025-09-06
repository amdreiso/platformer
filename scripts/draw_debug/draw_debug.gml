function draw_debug(){
	
	if (!Debug.debug) return;
	
	// Draw room partitions
	var rp_width = ROOM_TILE_WIDTH;
	var rp_height = ROOM_TILE_HEIGHT;
	
	for (var i = 0; i < room_width / rp_width; i++) {
		for (var j = 0; j < room_height / rp_height; j++) {
			draw_set_alpha(0.5);
			draw_line_color(i * rp_width, 0, i * rp_width, HEIGHT, c_blue, c_blue);
			draw_line_color(0, j * rp_height, WIDTH, j * rp_height, c_blue, c_blue);
			draw_set_alpha(1);
		}
	}
	
}