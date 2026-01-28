
enum SOUND_TYPE {
	SFX,
	Music,
}

function sound_play(type, snd, loop=false, gain=1, pitch=random_range(0.70, 1.00)){
	var gainType = 1;
	
	switch (type) {
		case SOUND_TYPE.SFX:
			gainType = Settings.audio.sfx;
			break;
		
		case SOUND_TYPE.Music:
			gainType = Settings.audio.music;
			break;
	}
	
	if (is_array(pitch)) {
		if (array_length(pitch) > 1) then pitch = random_range(pitch[0], pitch[1]);
	}
	var g = gain * gainType * Settings.audio.volume;
	
	//print($"Played audio: {snd}");
	
	return audio_play_sound(snd, 0, loop, g, 0, pitch);
	
}