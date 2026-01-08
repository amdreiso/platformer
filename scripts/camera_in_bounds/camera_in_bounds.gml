function camera_in_bounds(x, y){
	
	if (!instance_exists(Camera)) return;
	
	var w = Camera.defaultSize.width, h = Camera.defaultSize.height;
	var zoom = Camera.zoomLerp;
	var xx = Camera.x, yy = Camera.y;
	var ww = w / 2 * zoom;
	var hh = h / 2 * zoom;
	
	var left = (xx - ww);
	var right = (xx + ww);
	var down = (yy + hh);
	var up = (yy - hh);
	
	return (x > left && x < right && y > up && y < down);
	
}