
event_inherited();

// Enemy parent variable
applyGravity = false;
applyGroundCollisions = false;
drawOnSurface = false;
attackOnContact = false;
knockbackResistence = 0;

setHp(50);

onHitCallback.Register(function(){
	Junkdigger_Head.changeFacialExpression( sBoss_Junkdigger_FE_hurt );
});

defaultY = JUNKKEEPER_HAND_POSITION;

hitGround = false;
hitGroundCharged = false;
hitGroundChargedHeight = defaultY - 100;

sprite = sBoss_Junkdigger_Hand;

hsp = 0;
vsp = 0;


chooseState = function() {
	// choose between charging a throw or smashing attack
	state = choose(
		JUNKEEPER_HAND_STATE.ChargingSmash,
		JUNKEEPER_HAND_STATE.ChargingThrow
	);
}


// Change to random State when hit
onHitCallback.Register(function(){
	if (state == JUNKEEPER_HAND_STATE.Idling) {
		chooseState();
	}
	Junkdigger.setHp();
});


// Damages
smashDamage = 30;

junkBallSpeed = 4;


// States
enum JUNKEEPER_HAND_STATE {
	Idling,
	ChargingSmash,
	ChargingThrow,
	SmashGround,
}

state = JUNKEEPER_HAND_STATE.Idling;


createJunkParticles = function(x, y, value) {
	repeat (value) {
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
}


charge = function(follow=true) {
	if (y > hitGroundChargedHeight) {
		
		if (follow) x = lerp(x, Player.x, 0.03);
		
		y -= 0.5;
		
		var shake = 0.5;
		x += random_range(-shake, shake);
		y += random_range(-shake, shake);
		
		return false;
	}
	
	return true;
}

smashGround = function() {
	if (y < defaultY) {
		
		vsp += 2.0;
		
		if (place_meeting(x, y, Player)) {
			Player.hit(smashDamage);
		}
		
		return false;
		
	} else {
		
		vsp = 0;
		y = defaultY;
		
		camera_shake(10, 1.25);
		
		state = JUNKEEPER_HAND_STATE.Idling;
		
		createJunkParticles(x, y, 30);
		
		return true;
	}
}


// Enemy Parent function
setSpriteStates = function() {
	// returns native sprite variable
	return sprite;
}

