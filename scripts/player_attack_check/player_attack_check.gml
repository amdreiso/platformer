function player_attack_check(fn = function(obj){}, setUsed = true, sound=true){
	
	if (!instance_exists(PlayerAttack)) return;
	if (PlayerAttack.used) return;
	
	if (!place_meeting(x, y, PlayerAttack)) return;
	
	fn(PlayerAttack);
	
	if (setUsed) then PlayerAttack.used = true;
	if (sound) then sound_play(SOUND_TYPE.SFX, snd_hit1, false, 0.2, 1);
	
}