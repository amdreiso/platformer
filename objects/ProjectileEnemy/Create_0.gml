
dir = 0;
damage = 1;

sprite = sProjectile1;

collisions = function() {
	var destroy = [Collision, Collision_Slope];
	
	for (var i = 0; i < array_length(destroy); i++) {
		if (place_meeting(x, y, destroy[i])) {
			instance_destroy();
		}
	}
}
