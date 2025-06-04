

switch (room) {
	case rmLevel_Village:
		darkness = 0.70;
		
		if (instance_exists(Camera)) {
			layer_x(layer_get_id("Parallax_1"), lerp(0, Camera.x * 0.62, 0.1));
			layer_x(layer_get_id("Parallax_2"), lerp(0, Camera.x * 0.44, 0.1));
			layer_x(layer_get_id("Parallax_3"), lerp(0, Camera.x * 0.38, 0.1));
			layer_x(layer_get_id("Parallax_4"), lerp(0, Camera.x * 0.90, 0.1));
			layer_x(layer_get_id("Parallax_5"), lerp(0, Camera.x * 0.96, 0.1));
			
			layer_y(layer_get_id("Parallax_1"), lerp(0, Camera.y * 0.62, 0.1));
			layer_y(layer_get_id("Parallax_2"), lerp(0, Camera.y * 0.44, 0.1));
			layer_y(layer_get_id("Parallax_3"), lerp(0, Camera.y * 0.38, 0.1));
			layer_y(layer_get_id("Parallax_4"), lerp(0, Camera.y * 0.80, 0.1));
			layer_y(layer_get_id("Parallax_5"), lerp(0, Camera.y * 0.96, 0.1));
		}
		break;
}

