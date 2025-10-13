
if (Player.busy) return;

//invincible = (attacking);

movement();
handleHealth();

var phdir = player_get_hdir();

var dis = distance_to_object(Player);

// See player
if (dis < radius && !attacking && !hasSeenPlayer) {
	hasSeenPlayer = true;
}

// Move towards player if has seen player
if (hasSeenPlayer && !attacking) {
	hsp = spd * phdir;
}

// Attack on short distance
if (dis < attackingDistance && !attacking && !stun) {
	attacking = true;
	image_index = 0;
}

// attacking code
if (attacking) {
	
	stun = 0;
	hsp = 0;
	
	var index = floor(image_index);
	var when = (index > 3 && index < 5);
	
	if (when) {
		ableToAttack = true;
		//image_xscale = phdir;
	}
	
	if (sprite_index == spriteStates.attack) {
		on_last_frame(function(){
			ableToAttack = false;
			attacking = false;
			stun = attackCooldown;
		});
	}
	
}

if (!player_alive()) {
	attacking = false;
	return;
}

collisions();
