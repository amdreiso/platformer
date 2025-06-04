function camera_shake(value, pwr = 1){
	if (!instance_exists(Camera)) return;
	Camera.shakeValue = value;
	Camera.shakePower = pwr;
}