
surface = surface_create(room_width, room_height);

roomCode = function(){};

darkness = 0;

isSolid = false;
newRoom = true;
isCutscene = false;

hasBoss = false;


tilePos = function(val) {
	return val * 16;
}

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
	draw_set_valign(fa_middle);
	draw_set_font(fnt_boss);
	
	draw_text_transformed_color(WIDTH / 2, nameHeight, Boss.name, nameScale, nameScale, 0, nameColor, nameColor, nameColor, nameColor, 1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_console);
	
	var hbHeight = 50;
	var hbSprite = sHealthBar;
	var hbScale = 2;
	var hbXscale = 1;
	var hbColor = c_white;
	var hbOffsetX = 0;
	
	var maximumHp = Boss.defaultHp;
	var hpPart = (Boss.hp / Boss.defaultHp);
	
	for (var i = 0; i < maximumHp; i++) {
		hbSprite = sHealthBar;
		
		if (i == maximumHp - 1) {
			hbSprite = sHealthbar_end;
			hbXscale = 1;
			hbOffsetX = -1;
		}
		
		if (i == 0) {
			hbSprite = sHealthbar_end;
			hbXscale = -1;
		}
		
		if (i >= ceil(maximumHp * hpPart)) hbColor = c_dkgray;
		
		var width = 1;
		draw_sprite_ext(hbSprite, 0, (((WIDTH / 2) + i * width) - maximumHp * width / 2) + hbOffsetX, hbHeight, hbScale * hbXscale, hbScale, 0, hbColor, 1);
	}
}


checkPlayerTransitions = function(level) {
	if (!instance_exists(Player)) return;
	
	if (Player.levelTransitionCooldown > 0) return;
	
	var xx = Player.x;
	var yy = Player.y;
	
	var find = function(side) {
		if (Main.transition) return;
		
		var level = LEVEL.get(room);
		var len = array_length(level.components.transitions);
		
		for (var i = 0; i < len; i++) {
			var t = level.components.transitions[i];
			
			var tx = t.x div ROOM_TILE_WIDTH;
			var ty = t.y div ROOM_TILE_HEIGHT;
			var px = Player.x div ROOM_TILE_WIDTH;
			var py = Player.y div ROOM_TILE_HEIGHT;
			
			//print($"tx: {tx} px: {px} | ty: {ty} py: {py} | side: {side} tside: {t.side}");
			
			if (tx == px && ty == py && side == t.side) {
				
				return t;
			}
		}
		
		return false;
	}
	
	// Left transition
	if (xx < 0) {
		var transition = find("left");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) room_transition(roomID, "left", transition.playerOffset);
		}
	}
	
	// Right transition
	if (xx > room_width) {
		var transition = find("right");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) room_transition(roomID, "right", transition.playerOffset);
		}
	}
	
	// Up transition
	if (yy < 0) {
		var transition = find("up");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) room_transition(roomID, "up", transition.playerOffset);
		}
	}
	
	// Down transition
	if (yy > room_height) {
		var transition = find("down");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) room_transition(roomID, "down", transition.playerOffset);
		}
	}
	
}




screenlogs = [];

screenlog = function(str) {
	array_insert(screenlogs, 0, str);
	
	var len = array_length(screenlogs);
	if (len > 10) {
		array_delete(screenlogs, len, 1);
	}
}

drawScreenlog = function() {
	var len = array_length(screenlogs);
	for (var i = 0; i < len; i++) {
		draw_set_halign(fa_right);
		var scale = 1;
		var sep = 12 * scale;
		
		draw_text_outline(WIDTH, 200 - i * sep, screenlogs[i], scale, scale, 0, 1, fnt_console);
	}
	
	draw_set_halign(fa_center);
}





/*
var maxHpDisplay = 100;
var hpPart = (hpDisplay / defaultHp);
	
for (var i = 0; i < maxHpDisplay; i++) {
	var xoffset = (sprite_get_width(sItemDisplay) * guiScale) / 2 + margin;
	var width = (sprite_get_width(sHealthbar) * guiScale);
		
	var color = c_white;
		
	var sprite = sHealthbar;
	if (i == maxHpDisplay - 1) sprite = sHealthbar_end;
		
	if (i >= ceil(maxHpDisplay * hpPart)) color = c_dkgray;
		
	draw_sprite_ext(sprite, 0, xoffset + i * width, margin, guiScale, guiScale, 0, color, 1);
}
*/

