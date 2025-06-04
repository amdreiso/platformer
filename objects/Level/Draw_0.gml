
if (!surface_exists(surface)) return;



surface_set_target(surface);

draw_clear_alpha(c_white, 0);


// Draw darknesss uhhh
draw_set_alpha(darkness);
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Draw Light
gpu_set_blendmode(bm_subtract);


with (Light) {
	if (distance_to_object(Player) < 200) {
		//draw_raycast(x, y, 100, intensity, lightWidth);
		
		if (is_array(intensity)) {
			draw_circle(x, y, intensity[intensityIndex], false);
	
		} else {
			draw_circle(x, y, intensity, false);
		}
	}
}

with (Player) {
	draw_raycast(x, y, raycastCount, viewDistance, 2);
}


gpu_set_blendmode(bm_normal);

surface_reset_target();









