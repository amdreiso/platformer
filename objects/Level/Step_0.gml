

var level = LEVEL.Get(room);
if (level == -1) return;

checkPlayerTransitions(level);

hasBoss = (instance_exists(Boss));

if (newRoom) {
	
	screenlog($"Level: entered room {level.components.name}");
	
	STORY.load();
	
	// Reset surface size
	surface = surface_create(room_width, room_height);
	
	// Background Song
	var song = level.components.backgroundSong;
	
	//audio_stop_all();
	//if (!is_undefined(song) && !audio_is_playing(song)) {
	//	if (!is_undefined(backgroundSong)) audio_stop_sound(backgroundSong);
	//	backgroundSong = audio_play_sound(song, 0, true);
	//}
	
	// if room has a song
	if (song != -1 && backgroundSong != song && !audio_is_playing(song)) {
		// stop existing song
		audio_stop_all();
		
		// play current room's song
		backgroundSong = audio_play_sound(song, 0, true, Settings.audio.music * Settings.audio.volume);
	} else {
		
	}
	
	// Room Light Level
	darkness = level.components.darkness;
	isCutscene = level.components.isCutscene;
	
	roomCode = level.components.roomCode;
	
	level.components.load();
	
	
	// move player on transition
	var offset = Main.transitionPlayerOffset;
	
	switch (Main.transitionSide) {
		case "left":
			var p = new Vec2(room_width - PLAYER_BUFFER_ROOM_WIDTH, Main.transitionPlayerPosition.y);
			p.x += offset.x * ROOM_TILE_WIDTH;
			p.y += offset.y * ROOM_TILE_HEIGHT;
			
			player_set_position(p);
			break;
					
		case "right":
			var p = new Vec2(PLAYER_BUFFER_ROOM_WIDTH, Main.transitionPlayerPosition.y);
			p.x += offset.x * ROOM_TILE_WIDTH;
			p.y += offset.y * ROOM_TILE_HEIGHT;
			
			player_set_position(p);
			break;
					
		case "up":
			var p = new Vec2(Main.transitionPlayerPosition.x, room_height - PLAYER_BUFFER_ROOM_WIDTH - 8);
			p.x += offset.x * ROOM_TILE_WIDTH;
			p.y += offset.y * ROOM_TILE_HEIGHT;
			
			player_set_position(p);
			break;
					
		case "down":
			var p = new Vec2(Main.transitionPlayerPosition.x, PLAYER_BUFFER_ROOM_WIDTH);
			player_set_position(p);
			break;
	}
	
	showLevelName = 5 * 60;
	newRoom = false;
}

if (audio_is_playing(backgroundSong)) {
	audio_sound_gain(backgroundSong, backgroundSongGain, backgroundSongGainTime);
	audio_sound_pitch(backgroundSong, GameSpeed);
}

roomCode();


if (!instance_exists(LevelFX)) {
	instance_create_depth(0, 0, -99999999, LevelFX);
}


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

