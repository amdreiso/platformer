
movement();

if (place_meeting(x, y, Player)) {
	var xscale = 1;
	if (x < Player.x) xscale = -1;
	Player.hit(damage, xscale);
	
	repeat(50) {
		var range = 10;
		var pos = randvec2(x, y, range);
		instance_create_depth(pos.x, pos.y, depth, Particle_Explosion);
	}
	
	sound3D(-1, x, y, snd_explosion1, false, 0.5, [0.90, 1.00]);
	instance_destroy();
}

sleep = max(0, sleep - GameSpeed);

var updateTarget = function() {
	target = vec2(Player.x, Player.y-8);
	follow = true;
	sleep = sleepCooldown;
}


if (follow) {
	var dir = point_direction(x, y, target.x, target.y);
	
	if (sleep == 0) {
		hsp = lengthdir_x(spd, dir);
		vsp = lengthdir_y(spd, dir);
	} else {
		hsp = 0;
		vsp = 0;
	}
	
	// update target when drone reaches previous target
	if (position_tolerance(target.x, target.y, 10) && sleep == 0) {
		updateTarget();
	}
} else {
	// float a bit
	vsp = sin(current_time * 0.001) * 0.15;
}

collisions();
handleHealth();
