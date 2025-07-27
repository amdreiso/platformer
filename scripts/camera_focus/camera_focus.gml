function camera_focus(target){
	if (!instance_exists(Camera)) return;
	Camera.target = target;
}