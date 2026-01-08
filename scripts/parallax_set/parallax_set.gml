function parallax_set(layerName, xx = -1, yy = -1){
	
	if (!instance_exists(Camera)) return;
	
	//if (x != -1) layer_x(layer_get_id(layerName), lerp(0, Camera.pos.x * xx, 0.1));
	//if (y != -1) layer_y(layer_get_id(layerName), lerp(0, Camera.pos.y * yy, 0.1));
	
	if (xx != -1) layer_x(layer_get_id(layerName), Camera.pos.x * xx);
	if (yy != -1) layer_y(layer_get_id(layerName), Camera.pos.y * yy);
	
}