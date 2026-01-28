
isSolid = true;

dir = new Vec2();
used = false;
attacking = true;

initialDirection = 1;
knockback = 1;

effects = [];

angle = 0;
color = c_white;

collisions = function() {
	var frame = attacking;
	
	if (place_meeting(x, y, Switch)) {
		var inst = instance_nearest(x, y, Switch);
		
		with (inst) {
			if (!self.active) {
				sound_play(SOUND_TYPE.SFX, snd_switch_on, 0.44, 1);
				self.active = true;
				self.onActivation();
			}
		}
	}
}
