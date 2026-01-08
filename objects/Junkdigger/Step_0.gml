
event_inherited();


// Health
if (hp <= 0) {
	if (instance_exists(Cutscene)) return;
	
	sleep(10);
	
	children.DestroyAll();
	instance_destroy();
}

if (instance_exists(body)) {
	body.x = x + bodyOffset.x;
	body.y = y + bodyOffset.y;
	
	if (hsp != 0) {
		var dir = -sign(hsp);
		var shift = 5 * abs(hsp);
		body.image_angle = approach(body.image_angle, shift * dir, 0.5);

	} else {
		body.image_angle = approach(body.image_angle, 0, 0.5);
	
	}
}

if (instance_exists(head)) {
	head.x = x + headOffset.x;
	head.y = y + headOffset.y;
}

//hsp = (sin(current_time * 0.0005) * 0.25) - hsp / 2;
vsp = cos(current_time * 0.0011) * 0.1;

dead = (hp <= 0);
door.openable = (dead);

nohands = (!instance_exists(leftHand) && !instance_exists(rightHand));

if (nohands) {
	
	if (instance_exists(Cutscene)) return;
	if (gracePeriod > 0) return;
	
	with (head) {
		player_attack_check(function(atk){
			Junkdigger.hp -= atk.damage;
			hitFog = 10;
			
			sound_play(SOUND_TYPE.SFX, snd_hit1);
			
			if (Junkdigger.hp <= 0) {
				audio_stop_sound(Level.backgroundSong);

				var cs = instance_create_depth(0, 0, 0, Cutscene_Junkeeper);
				cs.cutsceneIndex = cs.cutsceneDeath;
			}
			
		});
	}
	
	x = lerp(x, Player.x, 0.033);
	
	interval_set(self, dynamiteCooldown, function(obj){
		var d = instance_create_depth(head.x, head.y - 30, depth, Junkdigger_Dynamite);
		dynamiteCooldown = choose(30, 60, 60, 90);
	});
}



