
surface = surface_create(room_width, room_height);


// Signals sent to objects with the same signalID across rooms
signalSeek				= false;
signalCallback		= new Callback();
signals						= {};
signals.list			= [];
signals.Send			= function(val = new Signal(0)) {
	signalSeek = true;
	array_push(signals.list, val);
	print($"Signal {val.signalID} sent for {val.time} frames");
}
signals.Seek = function() {
	if (signalSeek) {
		signalCallback.Run(self);
		signalSeek = false;
		print("Signal seek");
	}
}
signals.Update		= function() {
	// if new signal is sent, interactable objects will reply with a callback
	signals.Seek();
	
	for (var i = 0; i < array_length(signals.list); i++) {
		var s = signals.list[i];
		s.time = max(0, s.time - GameSpeed);
		if (s.time <= 0) {
			signalSeek = true;
			signals.Seek();
			array_delete(signals.list, i, 1);
		}
	}
}
signals.Has				= function(signalID) {
	for (var i = 0; i < array_length(signals.list); i++) {
		var s = signals.list[i];
		if (s.signalID == signalID) {
			return true;
		}
	}
	return false;
}


// Room
roomCode = function(){};
roomInstances = ds_map_create();

// Set every room with an array as room instances
var value = ds_map_find_first(LEVEL.entries);

while (value != undefined) {
	var state = ds_map_find_value(LEVEL.entries, value);
	
	roomInstances[? value] = [];
	print($"Level: roomInstances created: '{value}'");
	
	value = ds_map_find_next(LEVEL.entries, value);
}

roomInstanceAdd = function(inst) {
	array_push(Level.roomInstances[? room], inst);
}

roomInstanceDestroy = function(inst) {
	var value = ds_map_find_first(roomInstances);

	while (value != undefined) {
		var instances = ds_map_find_value(roomInstances, value);
		var len = array_length(instances);
		
		for (var i = 0; i < len; i++) {
			if (instances[i].object == inst) {
				if (instance_exists(inst)) then instance_destroy(inst);
				array_delete(instances, i, 1);
				print($"deleted instance {object_get_name(inst)}");
			}
		}
		
		value = ds_map_find_next(roomInstances, value);
	}
}


darkness = 0;

isSolid = false;
newRoom = true;
isCutscene = false;

hasBoss = false;
showLevelName = false;

doPlayerTransition = true;

goto = function(roomID) {
	room_goto(roomID);
	newRoom = true;
}

//room_goto(rmLevel_Cave_SpikeCorridor);

if (SaveState.progression.beggining_cutscene.played) {
	
	var level = SaveState.player.level;
	var pos = SaveState.player.pos;
	var xscale = SaveState.player.xscale;
	
	if (level != -1) {
		
		room_goto(level);
		player_set_position(pos);
		Player.image_xscale = xscale;
		
	} else {
		room_goto(rmLevel_Cave_Entrance);
	}
	
} else {
	room_goto(rmBegginingCutscene);
}


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
		
		var level = LEVEL.Get(room);
		var len = array_length(level.components.transitions);
		
		for (var i = 0; i < len; i++) {
			var t = level.components.transitions[i];
			
			var tx = t.x div ROOM_TILE_WIDTH;
			var ty = t.y div ROOM_TILE_HEIGHT;
			var px = Player.x div ROOM_TILE_WIDTH;
			var py = Player.y div ROOM_TILE_HEIGHT;
			
			//print($"tx: {tx} px: {px} | ty: {ty} py: {py} | side: {side} tside: {t.side}");
			
			print($"Level: tx: {tx} ty: {ty} | px: {px} py: {py}");
			
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
			if (!is_undefined(roomID)) {
				doPlayerTransition = true;
				room_transition(roomID, "left", transition.playerOffset);
			}
		}
	}
	
	// Right transition
	if (xx > room_width) {
		var transition = find("right");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) {
				doPlayerTransition = true; 
				room_transition(roomID, "right", transition.playerOffset);
			}
		}
	}
	
	// Up transition
	if (yy < 0) {
		var transition = find("up");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) {
				doPlayerTransition = true; 
				room_transition(roomID, "up", transition.playerOffset);
			}
		}
	}
	
	// Down transition
	if (yy > room_height) {
		var transition = find("down");
		if (transition) {
			var roomID = transition.roomID;
			if (!is_undefined(roomID)) {
				doPlayerTransition = true; 
				room_transition(roomID, "down", transition.playerOffset);
			}
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
	if (!Debug.debug) return;
	
	var len = array_length(screenlogs);
	for (var i = 0; i < len; i++) {
		draw_set_halign(fa_right);
		var scale = 1;
		var sep = 12 * scale;
		
		draw_text_outline(WIDTH, 200 - i * sep, screenlogs[i], scale, scale, 0, 1, fnt_console);
	}
	
	draw_set_halign(fa_center);
}

