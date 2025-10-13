
event_inherited();



if (place_meeting(x, y, Player) && state == JUNKEEPER_HAND_STATE.Idling) {
	chooseState();
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





