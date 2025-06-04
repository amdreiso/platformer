
alarm_set(0, irandom_range(20, 60) * 4);

with (instance_create_depth(x, y, depth, Particle)) {
	var big = random_range(0.20, 1.50);
	var force = 0.44;
	
	sprite = sParticle_Sparkle;
	
	image_angle = irandom(360);
	
	getRandomSprite = true;
	hsp = random_range(-1.00, 1.00) * force;
	vsp -= random(1.30) * force;
	destroyTime = irandom_range(10, 40) * 2;
	gravityApply = true;
	gravityForce = 0.05;
	
	xscale = choose(-1, 1) * big;
	yscale = choose(-1, 1) * big;
}


var snd = choose(snd_malfunction1, snd_malfunction2);
audio_play_sound_at(
	snd, x, y, 0, Sound.distance, Sound.dropoff, Sound.multiplier, false, -1, 0.005, 0, random_range(0.80, 1.00)
);
