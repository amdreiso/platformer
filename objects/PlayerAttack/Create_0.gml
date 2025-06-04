
isSolid = true;

dir = vec2();
used = false;
attacking = false;


collisions = function() {
	var frame = attacking;
	
	if (image_index == 6) {
		sound3D(-1, x, y, snd_electricity1, false, 0.3, [0.95, 1.00]);
	}
	
	if (place_meeting(x, y, Switch) && frame) {
		var inst = instance_nearest(x, y, Switch);
		if (!inst.active) {
			camera_shake(2);
			sound3D(-1, x, y, snd_hit2, false, 0.25, [0.95, 1.00]);
		}
		
		with (inst) {
			if (!active) {
				active = false;
				
				with (par_interactive) {
					if (ID == other.ID) {
						active = !active;
						animation = true;
					}
				}
			}
		}
	}
}


