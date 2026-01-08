function create_explosion_particles(x, y, range, val=10, spd = 0.05){

repeat (val * 3) {
	var pos = randvec2(x, y + sprite_height / 2, range);
		
	var part = instance_create_depth(pos.x, pos.y, depth, Particle);
	with (part) {
		
		gravityApply = false;
		
		var dir = spd;
		hsp = random_range(-dir, dir);
		vsp = random_range(-dir, 0) * 1;
		
		sprite = sParticle_Explosion;
		randomSprite = true;
		
		var r = 0.33;
		theta = random_range(-r, r);
		
		color = choose(
			c_red,
			c_orange,
			make_color_rgb(200, 70, 40),
		);
		
		scale = random_range(1.00, 3.00);
		scaleFactor = 0.003;
			
		image_angle = irandom(360);
		image_xscale = choose(-1, 1);
		image_yscale = choose(-1, 1);
		
		lifetime = 2.5 * 60;
		
		fadeout = true;
		fadeoutSpeed = random_range(0.05, 0.15) / 7;
			
	}
}

}