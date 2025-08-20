function parallax_set(layerName, x = 1, y = 1){
	
	if (!instance_exists(Camera)) return;
	
	if (x != -1) layer_x(layer_get_id(layerName), lerp(0, Camera.pos.x * x, 0.1));
	if (y != -1) layer_y(layer_get_id(layerName), lerp(0, Camera.pos.y * y, 0.1));
	
}