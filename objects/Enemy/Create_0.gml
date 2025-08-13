
// Enemy
behavior = 0;
isSolid = true;
target = Player;
lightLevel = 16;
lightAlpha = 0.25;
lightColor = c_white;

meleeDamage = 10;


// Movement
defaultSpd = 0.5;
spd = defaultSpd;
hsp = 0;
vsp = 0;
force = vec2();
applyGravity = true;

knockbackResistence = 1.5;

movement = function() {
	
	apply_force();
	
	x += hsp + force.x;
	y += vsp + force.y;
	
	if (applyGravity) vsp += Gravity;
	
}


// Collisions
collisions = function() {
	collision_set(Collision);
	collision_set(Collision_Slope);
	
	if (place_meeting(x, y, PlayerAttack) && PlayerAttack.attacking && !isHit) {
		var a = PlayerAttack;
		
		if (a.used) return;
		
		a.used = true;
		
		var knockback = 2.84 / knockbackResistence;
		force.x = a.initialDirection * (knockback);
		
		vsp = 0;
		vsp -= a.dir.y * knockback;
		
		hit(1);
	}
}


// Health
defaultHp = 5;
hp = defaultHp;
isHit = false;
hitCooldown = 0;
hitFog = 0;

handleHealth = function() {
	
	hitCooldown = max(0, hitCooldown - GameSpeed);
	hitFog = max(0, hitFog - GameSpeed);
	
	if (hitCooldown == 0) isHit = false;
	
}

hit = function(damage) {
	hp -= damage;
	isHit = true;
	hitCooldown = 10;
	
	hitFog = 10;
	
	camera_shake(2);
}


// Draw
weaponSprite = sClone1_weapon;

spriteStates = {
	idle: sClone1,
	move: sClone1,
}

draw = function() {
	var sprite = spriteStates.idle;
	
	if (hsp != 0) {
		sprite = spriteStates.move;
		image_xscale = sign(hsp);
	}
	
	sprite_index = sprite;
	
	gpu_set_fog((hitFog > 0), c_white, 0, 1);
	
	draw_self();
	//draw_outline(1, 0, Style.outlineColor);
	
	gpu_set_fog(false, c_white, 0, 1);
	
	
	if (weaponSprite == -1) return;
	
	var weaponYscale = 1;
	var weaponAngle = point_direction(x, y, target.x, target.y);
	
	if (target.x < x) weaponYscale = -1;
	
	surface_set_target(SurfaceHandler.surface);
	draw_sprite_ext(weaponSprite, 0, x, y, 1, weaponYscale, weaponAngle, c_white, 1);
	surface_reset_target();
}

