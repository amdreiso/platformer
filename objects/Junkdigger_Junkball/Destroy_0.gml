
camera_shake(5, 2);

sound_play(SOUND_TYPE.SFX, snd_ball_explosion, false, 1);

repeat (15) {
	with (instance_create_depth(x, y, depth, Particle)) {
		
		gravityApply = true;
		
		var hdir = 3;
		hsp = random_range(-hdir, hdir);
		vsp -= random_range(0.5, 4.0);
		
		sprite = sParticle_DumpYard;
		randomSprite = true;
		
		scale = random_range(0.50, 2.00);
		
		image_angle = irandom(360);
		image_xscale = choose(-1, 1);
		
	}
}

gamepad_set_vibration(Gamepad.ID, 1, 1);
