

var level = LEVEL.get(room);
if (level == -1) return;

hasBoss = (instance_exists(Boss));

if (newRoom) {
	
	audio_stop_all();
	
	// Background Song
	var song = level.components.backgroundSong;
	if (song != -1) {
		backgroundSong = audio_play_sound(song, 0, true);
	}
	
	// Room Light Level
	darkness = level.components.darkness;
	isCutscene = level.components.isCutscene;
	
	roomCode = level.components.roomCode;
	
	newRoom = false;
	
}

audio_sound_gain(backgroundSong, backgroundSongGain, backgroundSongGainTime);

roomCode();



/*
switch (room) {
	case rmLevel_CaveEntrance:
		if (newRoom) {
			newRoom = false;
			audio_play_sound(snd_dreamsOfAnElectricMind, 0, false);
		}
		
		darkness = 0.97;
		break;
	
	case rmLevel_CaveVillage:
		if (newRoom) {
			newRoom = false;
			audio_play_sound(snd_mechanicalHope, 0, false);
		}
		
		darkness = 0.80;
		
		if (instance_exists(Camera)) {
			
			layer_x(layer_get_id("Parallax_2"), lerp(0, Camera.x * 0.44, 0.1));
			layer_x(layer_get_id("Parallax_3"), lerp(0, Camera.x * 0.38, 0.1));
			layer_x(layer_get_id("Parallax_4"), lerp(0, Camera.x * 0.90, 0.1));
			layer_x(layer_get_id("Parallax_5"), lerp(0, Camera.x * 0.96, 0.1));
			
			layer_y(layer_get_id("Parallax_1"), lerp(0, Camera.y * 0.62, 0.1));
			layer_y(layer_get_id("Parallax_2"), lerp(0, Camera.y * 0.44, 0.1));
			layer_y(layer_get_id("Parallax_3"), lerp(0, Camera.y * 0.38, 0.1));
			layer_y(layer_get_id("Parallax_4"), lerp(0, Camera.y * 0.80, 0.1));
			layer_y(layer_get_id("Parallax_5"), lerp(0, Camera.y * 0.96, 0.1));
		}
		break;
}

