
x += hsp;
y += vsp;

if (place_meeting(x, y, Player)) hitGround = true;


if (hitGround) {
	
	if (!hitGroundCharged) {
		
		if (y > hitGroundChargedHeight) {
			
			x = lerp(x, Player.x, 0.03);
			y -= 0.5;
			
			var shake = 0.5;
			x += random_range(-shake, shake);
			y += random_range(-shake, shake);
		
			state = "charging";
			
		} else {
			
			hitGroundCharged = true;
		
			state = "charged";
			
		}
		
	}	else {
		
		if (y < defaultY) {
			
			vsp += 2.0;
			state = "hitting";
			
			if (place_meeting(x, y, Player)) {
				Player.hit(10);
			}
			
		} else {
			
			vsp = 0;
			y = defaultY;
		
			camera_shake(10, 1.25);
			hitGround = false;
			hitGroundCharged = false;
		
			state = "idling";
			
			repeat (30) {
				with (instance_create_depth(x, y, depth, Particle)) {
					
					gravityApply = true;
					
					var hdir = 5;
					hsp = random_range(-hdir, hdir);
					vsp -= random_range(0.5, 7.0);
					
					sprite = sParticle_DumpYard;
					getRandomSprite = true;
					
					scale = random_range(0.50, 2.00);
					
					image_angle = irandom(360);
					image_xscale = choose(-1, 1);
					
				}
			}
			
		}
	}
	
}
