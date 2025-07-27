function camera_shake(shake, pow=1){
	if (!instance_exists(Camera)) return;
	Camera.shakeValue = shake;
	Camera.shakePower = pow;
}