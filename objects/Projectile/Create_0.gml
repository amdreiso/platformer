
// Projectile Stats
shooter = noone;

dir = 0;
damage = 1;

used = false;
destroyOnCollisions = true;
destroyOnContact = true;


// Draw
sprite = sProjectile1;
scale = 1;


// Collisions

collisions = new Callback();

collisions.Register(function() {
	var destroy = [Collision, Collision_Slope];
	
	if (destroyOnCollisions) {
		for (var i = 0; i < array_length(destroy); i++) {
			if (place_meeting(x, y, destroy[i])) {
				instance_destroy();
			}
		}
	}
	
});
