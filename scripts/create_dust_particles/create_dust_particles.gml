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
		randomSprite = true;
		
		lifetime = irandom_range(3, 6) * 60;
			
		scale = random_range(1.00, 1.50);
		
		alpha = random_range(0.44, 0.77);
			
		image_angle = irandom(360);
		image_xscale = choose(-1, 1);
		image_yscale = choose(-1, 1);
			
		fadeout = false;
		
	}
}

}