
if (active) {
	sprite_index = sInstance_FireBowl_Active;
	
} else {
	sprite_index = sInstance_FireBowl_Inactive;
	
	player_attack_check(function(atk) {
		if (effect_has(atk, EFFECT_ID.Burning)) {
			if (!active) {
				repeat (20) {
					var pos = irandvec2(x, y - sprite_height, 5);
					var p = instance_create_depth(pos.x, pos.y, depth, Particle);
					p.sprite = choose(sParticle_Flames, sParticle_Smoke);
					p.randomSprite = true;
					p.color = choose(c_white, c_ltgray);
					p.lifetime = irandom_range(120, 140);
					var h = 0.3, v = 0.55;
					p.hsp = random_range(-h, h);
					p.vsp = -random_range(v / 2, v);
					p.xscale = choose(-1, 1);
					p.scale = random_range(0.5, 1.0);
					p.scaleFactor = -0.005;
					p.gravityApply = false;
					p.theta = random_range(-0.05, 0.05);
					p.updateCallback.Register(function(p){
						var falloff = 0.005;
						if (p.hsp != 0) p.hsp += falloff * -sign(p.hsp);
						if (p.vsp != 0) p.vsp += falloff * -sign(p.vsp);
					});
				}
				active = true;
			}
		}
		
	}, false, false);
}
