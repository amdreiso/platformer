
event_inherited();

var pitch = 1;

movement();

if (!audio_is_playing(snd_drone)) {
	sound = sound3D(-1, x, y, snd_drone, true, 0.4, pitch);
	
} else {
	audio_sound_pitch(sound, pitch);

}

if (place_meeting(x, y, Player)) {
	var xscale = 1;
	if (x < Player.x) xscale = -1;
	Player.hit(damage, xscale);
	
	sound3D(-1, x, y, snd_explosion1, false, 0.5, [0.90, 1.00]);
	
	audio_stop_sound(sound);
	instance_destroy();
}

sleep = max(0, sleep - GameSpeed);

var updateTarget = function() {
	target = new Vec2(Player.x, Player.y - 8);
	follow = true;
	sleep = choose(50, 60, 70, 80) / 2;
}


if (follow) {
	var dir = point_direction(x, y, target.x, target.y);
	
	// Only move when not sleeping
	if (sleep == 0) {
		hsp = round(lengthdir_x(spd, dir));
		vsp = round(lengthdir_y(spd, dir));
		
	} else {
		hsp = 0;
		vsp = 0;
		
	}
	
	// update target when drone reaches previous target
	if (position_tolerance(target.x, target.y, 5) && sleep == 0) {
		updateTarget();
	}
} else {
	// float a bit
	vsp = sin(current_time * 0.001) * 0.15;
}

handleHealth();




if (hp <= 0) audio_stop_sound(sound);
