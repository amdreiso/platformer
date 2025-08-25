
surface = surface_create(room_width, room_height);

roomCode = function(){};

darkness = 0.94;

isSolid = false;
newRoom = true;
isCutscene = false;

hasBoss = false;

screen = {
	flashAlpha: 0,
	flashTime: 0.01,
	flashColor: c_white,
};

drawScreenFlash = function() {
	screen.flashAlpha = max(0, screen.flashAlpha - screen.flashTime);
	
	draw_set_alpha(screen.flashAlpha);
	draw_rectangle_color(0, 0, WIDTH, HEIGHT, screen.flashColor, screen.flashColor, screen.flashColor, screen.flashColor, false);
	draw_set_alpha(1);
}


// Music
backgroundSong						= -1;
backgroundSongGain				= 1;
backgroundSongGainTime		= 1;
setBackgroundSong					= function(snd, loop=false, gain=1, gaintime=1) {
	
	
	// Stop current song if playing
	if (!is_undefined(backgroundSong)) {
		audio_stop_sound(backgroundSong);
	}
	
	// Play new song 
	backgroundSong = audio_play_sound(snd, 0, loop);
	backgroundSongGain = gain;
	backgroundSongGainTime = gaintime;
}

setBackgroundSongGain = function(gain, gaintime) {
	// Stop current song if playing
	backgroundSongGain = gain;
	backgroundSongGainTime = gaintime;
}


drawBossbar = function() {
	
	if (!hasBoss) return;
	
	var nameScale = 1.5;
	var nameColor = Boss.nameColor;
	var nameHeight = 100;
	
	draw_set_halign(fa_center);
	draw_set_font(fnt_boss);
	
	draw_text_transformed_color(WIDTH / 2, HEIGHT - nameHeight, Boss.name, nameScale, nameScale, 0, nameColor, nameColor, nameColor, nameColor, 1);
	
	draw_set_halign(fa_left);
	draw_set_font(fnt_console);
	
	var hbHeight = 50;
	var hbSprite = sHealthbar;
	var hbScale = 2;
	var hbXscale = 1;
	
	for (var i = -Boss.defaultHp / 2; i < Boss.defaultHp / 2; i++) {
		if (i == (-Boss.defaultHp / 2)) {
			hbSprite = sHealthbar_end;
			hbXscale = -1;
		}
		
		if (i == (Boss.defaultHp / 2)) {
			hbSprite = sHealthbar_end;
			hbXscale = 1;
		}
		
		hbSprite = sHealthbar;
		
		var width = sprite_get_width(hbSprite);
		
		draw_sprite_ext(hbSprite, 0, (WIDTH / 2) + i * width, HEIGHT - hbHeight, hbScale * hbXscale, hbScale, 0, c_white, 1);
		
	}
	
}
