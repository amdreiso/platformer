
shooter = noone;

dir = 0;
damage = 1;

used = false;
destroyOnCollisions = true;
destroyOnContact = true;
destroyOnPlayerAttack = true;

sprite = sProjectile1;
scale = 1;

collisions = function() {
	var destroy = [Collision, Collision_Slope];
	
	if (destroyOnCollisions) {
		for (var i = 0; i < array_length(destroy); i++) {
			if (place_meeting(x, y, destroy[i])) {
				instance_destroy();
			}
		}
	}
	
	player_attack_check(function(){
		if (!destroyOnPlayerAttack) return;
		instance_destroy();
	}, false, false);
	
}
