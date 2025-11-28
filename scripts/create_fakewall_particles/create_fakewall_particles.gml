function create_fakewall_particles(val){
	
	repeat (val) {
		if (surface_exists(surface)) {
			var color = surface_getpixel(surface, irandom(sprite_width), irandom(sprite_height));
			var w, h;
			w = sprite_get_width(sprite);
			h = sprite_get_height(sprite);
		
			var range = min(w, h) / 3;
		
			var pos = irandvec2(x + w / 2, y + h / 2, range);
			var particle = instance_create_depth(pos.x, pos.y, depth, Particle);
			if (instance_exists(particle)) {
				particle.sprite = sParticle_Fakewall;
				particle.randomSprite = true;
				particle.lifetime = irandom_range(2, 5) * 60;
				particle.gravityApply = true;
				particle.gravityForce = random_range(0.055, 0.075);
				particle.scale = random_range(1.00, 2.25);
				particle.angle = irandom(360);
		
				particle.knockback.x = random_range(-1.00, 1.00) * 1;
				particle.vsp -= random_range(0.10, 1.00);
		
				particle.collisions = [Collision];
				particle.color = color_darkness(color, irandom_range(0, 3));
			}
		}
	}
	
}