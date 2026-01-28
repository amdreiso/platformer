function camera_set_position(x, y){
	if (!instance_exists(Camera)) return;
	print($"Camera: position set to x: {x} y: {y}");
	Camera.x = x; Camera.y = y;
	Camera.xTo = x; Camera.yTo = y;
}