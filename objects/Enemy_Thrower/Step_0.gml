
if (Sleep) return;

if (Player.busy) return;

movement();
handleHealth();

thrownCooldown = max(0, thrownCooldown - GameSpeed);
tick += GameSpeed + distance_to_object(Player) / 10;

var phdir = player_get_hdir();
var throwTimeArray = [10, 30, 40, 50, 70];
	
if (distance_to_object(Player) < radius) {
	
	hasSeenPlayer = true;
	
	// Walk away
	hsp = spd * -phdir;
	
	
	// Throw Projectile
	if (thrownCooldown == 0) {
		var p = instance_create_depth(x, y, depth, Enemy_Thrower_Projectile);
			
		var hspd = 0.3;
		p.hsp = phdir * hspd;
		p.vsp -= 1.48;
		p.shooter = self;
		p.damage = projdamage;
		
		throwCount ++;
		
		throwTime = array_get_random(throwTimeArray);
		if (throwCount == 3) {
			throwTime = 175;
			throwCount = 0;
		}
		
		thrownCooldown = throwTime;
	}
	
	tick = 0;
} else {
	
	if (hasSeenPlayer && tick > 7 * 60) {
		hsp = spd / 2.5 * phdir;
		image_xscale = phdir;
		
	} else {
		hsp = 0;
		image_xscale = phdir;
	}
	
}

collisions();


effect_run(self, "update");
effect_apply();

