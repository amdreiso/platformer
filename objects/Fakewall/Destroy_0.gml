
repeat (100) {
	if (surface_exists(surface)) {
		var color = surface_getpixel(surface, irandom(sprite_width), irandom(sprite_height));
		if (color == 0) continue;
		
		var w, h;
		w = sprite_width;
		h = sprite_height;
		
		var range = min(w, h) / 3;
		
		var pos = irandvec2(x + w / 2, y + h / 2, range);
		var particle = instance_create_depth(pos.x, pos.y, depth, Particle);
		if (instance_exists(particle)) {
			particle.sprite = sParticle_Fakewall;
			particle.randomSprite = true;
			particle.gravityApply = true;
			particle.gravityForce = random_range(0.055, 0.075);
			particle.scale = random_range(1.00, 2.25);
			particle.angle = irandom(360);
			particle.roll = true;
		
			particle.knockback.x = random_range(-1.00, 1.00) * 2;
			particle.vsp -= random_range(0.10, 1.00);
		
			particle.collisions = [Collision];
			particle.color = color;
		
			particle.fadeout = true;
			particle.fadeoutSpeed = random_range(0.010, 0.050);
			particle.fadeoutCooldown = irandom_range(4, 8) * 60;
		}
	}
}

onDestroy();
