function player_attack_check(fn = function(){}, setUsed = true){
	
	if (place_meeting(x, y, PlayerAttack)) {
		if (!PlayerAttack.used) {
			fn(PlayerAttack);
			if (setUsed) PlayerAttack.used = true;
		}
	}
	
}