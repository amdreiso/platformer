function player_attack_check(fn = function(){}, setUsed = true, sound=true){
	
	if (place_meeting(x, y, PlayerAttack)) {
		if (!PlayerAttack.used) {
			fn(PlayerAttack);
			if (setUsed) PlayerAttack.used = true;
			
			if (sound) then audio_play_sound(snd_hit1, 0, false, 0.2, 0, 1);
		}
	}
	
}