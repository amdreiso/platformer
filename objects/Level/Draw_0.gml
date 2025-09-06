
if (!surface_exists(surface)) return;


surface_set_target(surface);

draw_clear_alpha(c_black, 0);


//// Draw darknesss uhhh
//draw_set_alpha(darkness * !Debug.debug);
//draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
//draw_set_alpha(1);


//// Draw Light
//gpu_set_blendmode(bm_eq_subtract);


//with (Light) {
//	if (distance_to_object(Player) < Camera.size.width) {
//		//draw_raycast(x, y, 100, intensity, lightWidth);
		
//		if (is_array(intensity)) {
//			draw_circle_color(x, y, intensity[intensityIndex], c_white, c_black, false);
	
//		} else {
//			draw_circle_color(x, y, intensity, c_white, c_black, false);
//		}
//	}
//}

//with (Player) {
//	//draw_raycast(x, y, raycastCount, viewDistance, 5);
	
//	draw_circle_color(x, y, viewDistance, c_white, c_black ,false);
//}


//with (Enemy) {
//	//draw_raycast(x, y, raycastCount, viewDistance, 5);
	
//	draw_circle(x, y, lightLevel, false);
//}


gpu_set_blendmode(bm_normal);

surface_reset_target();










