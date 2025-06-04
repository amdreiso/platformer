
ID = 0;

output.roomID = rmLevel_Village;
output.playerPosition = vec2(690, 598);

output.onEnter = function() {
	audio_play_sound(snd_mechanical_hope, 0, false);
}
