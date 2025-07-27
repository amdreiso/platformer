
ID = 0;

output.roomID = rmLevel_Cave_Village;
output.playerPosition = vec2(690, 598);

output.onEnter = function() {
	audio_play_sound(snd_mechanicalHope, 0, false);
}
