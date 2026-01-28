

var level = LEVEL.Get(room);
if (level == -1) return;

checkPlayerTransitions(level);

hasBoss = (instance_exists(Boss));

if (newRoom) {
	
	// Camera code
	var zoom = level.components.cameraZoom;
	camera_set_zoom(zoom);
	camera_focus(Player);
	camera_set_position(Player.x, Player.y);
	
	screenlog($"Level: entered room {level.components.name}");
	
	//SaveManager.Load();
	
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
	
	
	
	// On load
	level.components.load();
	
	
	// move player on transition
	var offset = Main.transitionPlayerOffset;
	var cw = 16, ch = 16;
	
	if (doPlayerTransition) {
		switch (Main.transitionSide) {
			case "left":
				var p = new Vec2(room_width - PLAYER_BUFFER_ROOM_WIDTH, Main.transitionPlayerPosition.y);
				p.x += offset.x * cw;
				p.y += offset.y * ch;
			
				player_set_position(p);
				break;
					
			case "right":
				var p = new Vec2(PLAYER_BUFFER_ROOM_WIDTH, Main.transitionPlayerPosition.y);
				p.x += offset.x * cw;
				p.y += offset.y * ch;
			
				player_set_position(p);
				break;
					
			case "up":
				var p = new Vec2(Main.transitionPlayerPosition.x, room_height - PLAYER_BUFFER_ROOM_WIDTH - 8);
				p.x += offset.x * cw;
				p.y += offset.y * ch;
			
				player_set_position(p);
				break;
					
			case "down":
				var p = new Vec2(Main.transitionPlayerPosition.x, PLAYER_BUFFER_ROOM_WIDTH);
				player_set_position(p);
				break;
		}
	}
	
	// Create persistent instances
	var instances = roomInstances[? room];
	var len = array_length(instances);
		
	if (len != 0) {
		for (var i = 0; i < len; i++) {
			instances[i].Create();
		}
	}
	
	showLevelName = 5 * 60;
	newRoom = false;
	doPlayerTransition = false;
	
	// Try finding room achievement
	ACHIEVEMENT.Try(ACHIEVEMENT_TYPE.Location);
	
	
	// Saving Current State
}

if (audio_is_playing(backgroundSong)) {
	audio_sound_gain(backgroundSong, backgroundSongGain, backgroundSongGainTime);
	audio_sound_pitch(backgroundSong, GameSpeed);
}

roomCode();

if (!instance_exists(LevelFX)) {
	instance_create_depth(0, 0, -99999999, LevelFX);
}

signals.Update();


