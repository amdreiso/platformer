function camera_focus(target){
	if (!instance_exists(Camera)) return;
	print($"Camera: focuse set to {target}");
	Camera.target = target;
}