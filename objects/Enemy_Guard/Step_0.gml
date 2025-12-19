
event_inherited();

if (target == noone) return;

var dir = point_direction(x, 0, target.x, 0);
hsp = lengthdir_x(spd, dir);


shootTimer = max(0, shootTimer - GameSpeed);
burstCooldown = max(0, burstCooldown - GameSpeed);

if (shootTimer == 0) {
	if (burstCooldown == 0 && burstCount <= burstAmount) {
		burstCooldown = 30;
		burstCount ++;
		
		// Projectile
		with (instance_create_depth(x, y, depth, Projectile_Enemy)) {
			self.direction = point_direction(other.x, other.y, other.target.x, other.target.y);
			self.speed = 3;
			self.shooter = other;
		}
		
		sound3D(-1, x, y, snd_gunshot1, false, 0.2, random_range(0.86, 1.00));
		
		// Light
		var flash = instance_create_depth(x, y, depth, Light);
		with (flash) {
			intensity = 100;
			intensityDrop = 10;
			
			sprite = -1;
		}
		
		if (burstCount == burstAmount) {
			burstCount = 0;
			shootTimer = 3 * 60;
		}
	}
}

