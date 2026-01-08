
event_inherited();

if (place_meeting(x, y, Player) && state == JUNKEEPER_HAND_STATE.Idling && hp > defaultHp / 2) {
	chooseState();
	
}

var hp0 = 0;
var hp1 = 0;

if (instance_exists(Junkdigger.leftHand)) {
	hp0 = Junkdigger.leftHand.hp;
}

if (instance_exists(Junkdigger.rightHand)) {
	hp1 = Junkdigger.rightHand.hp;
}

var th = defaultHp / 2;
if (hp0 < th || hp1 < th) {
	
	interval_set(self, 60, function(){
		if (state != JUNKEEPER_HAND_STATE.Idling) return;
		chooseState();
	});
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
			var dir = 1;
			if (Player.x < x) dir = -1;
			
			ball.direction = point_direction(x, y, Player.x, Player.y) + irandom_range(0, 70) * dir;
			ball.speed = junkBallSpeed;
			
			state = JUNKEEPER_HAND_STATE.SmashGround;
		}
		
		sprite = sBoss_Junkdigger_Hand_Junk;
		
		break;
	
	case JUNKEEPER_HAND_STATE.SmashGround:
		var hasSmashed = smashGround();
		if (hasSmashed) {
			state = JUNKEEPER_HAND_STATE.Idling;
			
			sound_play(SOUND_TYPE.SFX, snd_explosion4);
			gamepad_set_vibration(Gamepad.ID, 1, 1);
		}
		
		sprite = sBoss_Junkdigger_Hand;
		
		break;
	
}





