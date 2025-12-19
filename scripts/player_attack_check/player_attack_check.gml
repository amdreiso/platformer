function player_attack_check(fn = function(obj){}, setUsed = true, sound=true){
	
	if (!instance_exists(PlayerAttack)) return;
	if (PlayerAttack.used) return;
	
	if (!place_meeting(x, y, PlayerAttack)) return;
	
	fn(PlayerAttack);
	
	if (setUsed) then PlayerAttack.used = true;
	if (sound) then audio_play_sound(snd_hit1, 0, false, 0.2, 0, 1);
	
}