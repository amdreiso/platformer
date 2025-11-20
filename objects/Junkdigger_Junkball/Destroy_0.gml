
camera_shake(3);

repeat (15) {
	with (instance_create_depth(x, y, depth, Particle)) {
		
		gravityApply = true;
		
		var hdir = 5;
		hsp = random_range(-hdir, hdir);
		vsp -= random_range(0.5, 7.0);
		
		sprite = sParticle_DumpYard;
		randomSprite = true;
		
		scale = random_range(0.50, 2.00);
		
		image_angle = irandom(360);
		image_xscale = choose(-1, 1);
		
	}
}
