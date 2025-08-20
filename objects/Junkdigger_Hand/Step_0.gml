
x += hsp;
y += vsp;


//if (hitGround) {
	
//	if (!hitGroundCharged) {
		
//		if (y > hitGroundChargedHeight) {
			
//			x = lerp(x, Player.x, 0.03);
//			y -= 0.5;
			
//			var shake = 0.5;
//			x += random_range(-shake, shake);
//			y += random_range(-shake, shake);
		
//			state = choose(JUNKEEPER_HAND_STATE.ChargingAttack, JUNKEEPER_HAND_STATE.ChargingThrow);
			
//		} else {
			
//			hitGroundCharged = true;
		
//			state = "charged";
			
//		}
		
//	}	else {
		
//		if (y < defaultY) {
			
//			vsp += 2.0;
//			state = "hitting";
			
//			if (place_meeting(x, y, Player)) {
//				Player.hit(10);
//			}
			
//		} else {
			
//			vsp = 0;
//			y = defaultY;
		
//			camera_shake(10, 1.25);
//			hitGround = false;
//			hitGroundCharged = false;
		
//			state = "idling";
			
//			repeat (30) {
//				with (instance_create_depth(x, y, depth, Particle)) {
					
//					gravityApply = true;
					
//					var hdir = 5;
//					hsp = random_range(-hdir, hdir);
//					vsp -= random_range(0.5, 7.0);
					
//					sprite = sParticle_DumpYard;
//					getRandomSprite = true;
					
//					scale = random_range(0.50, 2.00);
					
//					image_angle = irandom(360);
//					image_xscale = choose(-1, 1);
					
//				}
//			}
			
//		}
//	}
	
//}

if (place_meeting(x, y, Player) && state == JUNKEEPER_HAND_STATE.Idling) {
	
	// choose between charging a throw or smashing attack
	state = choose(
		JUNKEEPER_HAND_STATE.ChargingSmash,
		JUNKEEPER_HAND_STATE.ChargingThrow
	);
	
}

switch (state) {
	
	case JUNKEEPER_HAND_STATE.Idling:
		sprite = sBoss_Junkdigger_Hand;
		
		break;
		
	case JUNKEEPER_HAND_STATE.ChargingSmash:
		var isCharged = charge();
		if (isCharged) {
			state = JUNKEEPER_HAND_STATE.SmashGround;
		}
		sprite = sBoss_Junkdigger_Hand;
		
		break;
		
	case JUNKEEPER_HAND_STATE.ChargingThrow:
		var isCharged = charge(false);
		if (isCharged) {
			var ball = instance_create_depth(x, y, depth, Junkdigger_Junkball);
			ball.direction = point_direction(x, y, Player.x, Player.y);
			ball.speed = junkBallSpeed;
			
			state = JUNKEEPER_HAND_STATE.SmashGround;
		}
		sprite = sBoss_Junkdigger_Hand_Junk;
		
		break;
	
	case JUNKEEPER_HAND_STATE.SmashGround:
		var hasSmashed = smashGround();
		if (hasSmashed) {
			state = JUNKEEPER_HAND_STATE.Idling;
		}
		sprite = sBoss_Junkdigger_Hand;
		
		break;
	
}





