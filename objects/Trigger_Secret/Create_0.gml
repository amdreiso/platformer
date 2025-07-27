
event_inherited();
trigger = function() {
	with (Player) {
		secret = true;
	}
	
	audio_play_sound(snd_secret1, 0, false);
}
