function parallax_set(layerName, x = 1, y = 1){
	
	if (!instance_exists(Camera)) return;
	
	layer_x(layer_get_id(layerName), lerp(0, Camera.x * x, 0.1));
	layer_y(layer_get_id(layerName), lerp(0, Camera.y * y, 0.1));
	
}