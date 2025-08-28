function create_dust_particles(x, y, range, val=10, spd = 0.15){

repeat (val) {
	var pos = randvec2(x, y + sprite_height / 2, range);
		
	var part = instance_create_depth(pos.x, pos.y, depth, Particle);
	with (part) {
			
		gravityApply = false;
			
		var dir = spd;
		hsp = random_range(-dir, dir);
		vsp = random_range(-dir, dir);
			
		sprite = sParticle_Dust;
		getRandomSprite = true;
			
		scale = random_range(1.00, 1.50);
			
		image_angle = irandom(360);
		image_xscale = choose(-1, 1);
		image_yscale = choose(-1, 1);
			
		fadeout = true;
		fadeoutSpeed = random_range(0.05, 0.15) / 5;
			
	}
}

}