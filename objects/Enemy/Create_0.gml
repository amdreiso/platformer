
// Enemy
behavior = 0;
isSolid = true;
target = Player;
lightLevel = 16;
lightAlpha = 0.25;
lightColor = c_white;

effects = [];

damage = 10;

attackOnContact = true;
ableToAttack = true;

deathSound = choose(snd_explosion1, snd_explosion3, snd_explosion4);

invincible = false;



// Movement
defaultSpd = 0.5;
spd = defaultSpd;
hsp = 0;
hspLast = 0;
vsp = 0;
knockback = new Vec2();
applyGravity = true;
applyGroundCollisions = true;
drawOnSurface = true;
onSlope = false;
stun = 0;
stunWhenHit = 0;
attacking = false;

knockbackResistence = 1;

movement = function() {
	
	stun = max(0, stun - GameSpeed);
	
	if (stun > 0) {
		return;
	}
	
	// Knockback
	knockback_apply();
	
	x += (hsp + knockback.x) * GameSpeed;
	y += (vsp + knockback.y) * GameSpeed;
	
	if (applyGravity) vsp += Gravity;
	
}


// Collisions
collisions = function() {
	if (applyGroundCollisions) {
		collision_set(Collision);
		collision_set(Collision_Slope);
		
	}
	
	if (place_meeting(x, y + 1, Collision_Slope)) {
		onSlope = true;
	}
	
	// Push the player's y position up by a pixel so it doesnt get stuck on turns on slopes
	if (hsp != hspLast && hsp != 0) {
		hspLast = hsp;
		if (onSlope) {
			y -= 1;
		}
	}
	
	if (onSlope) {
		hsp = round(hsp);
	}
	
	// Player attack 
	player_attack_check(function(a){
		if (isHit) return;
		
		var k = (0.54 * a.knockback) * knockbackResistence;
		knockback.x = a.initialDirection * (k);
		
		vsp = 0;
		vsp -= a.dir.y * k;
		
		hitByPlayer = true;
		hit(a.damage);
		
		
		// Spawn attack particle
		var pos = randvec2(x, y, 6);
		var part = instance_create_depth(pos.x, pos.y, depth, Particle_Attack);
		
		camera_shake(5, 1);
		
		// Transfer effects from players attack to the enemy
		effect_transfer(a.effects, self);
	});
	
	bound_to_room();
	
	//if (place_meeting(x, y, PlayerAttack) && !isHit) {
	//	var a = PlayerAttack;
		
	//	if (a.used) return;
		
	//	a.used = true;
		
	//	var knockback = 2.84 / knockbackResistence;
	//	force.x = a.initialDirection * (knockback);
		
	//	vsp = 0;
	//	vsp -= a.dir.y * knockback;
		
	//	hit(a.damage);
	//}
}


// Health
defaultHp = 100;
hp = defaultHp;
isHit = false;
hitCooldown = 0;
hitFog = 0;


onHit = false;
onHitCallback = new Callback();

setHp = function(value) {
	defaultHp = value;
	hp = value;
}

handleHealth = function() {
	
	hitCooldown = max(0, hitCooldown - GameSpeed);
	hitFog = max(0, hitFog - GameSpeed);
	
	if (hitCooldown == 0) isHit = false;
	
	if (hp <= 0) {
		instance_destroy();
	}
	
	if (onHit) {
		onHitCallback.Run(self);
		onHit = false;
	}
	
}

hitByPlayer = false;

hit = function(damage) {
	if (invincible) return false;
	
	hp -= damage;
	isHit = true;
	hitCooldown = 10;
	
	hitFog = 10;
	onHit = true;
	
	if (hitByPlayer) { 
		camera_shake(5);
		stun = stunWhenHit;
		
		hitByPlayer = false;
	}
	
	create_popup_particle(damage);
	
	return true;
}


// Draw
weaponSprite = -1;
angle = 0;

spriteStates = {
	idle: sClone1,
	move: sClone1,
	stun: sClone1,
	attack: sClone1,
}

setSpriteStates = function() {
	
	if (stun > 0) {
		return spriteStates.stun;
	}
	
	if (hsp != 0) {
		image_xscale = sign(hsp);
		return spriteStates.move;
	}
	
	if (attacking) {
		return spriteStates.attack;
	}
	
	return spriteStates.idle;
}

weaponDraw = function() {
	if (weaponSprite == -1) return;
	
	var weaponYscale = 1;
	var weaponAngle = point_direction(x, y, target.x, target.y);
	
	if (target.x < x) weaponYscale = -1;
	
	surface_set_target(SurfaceHandler.surface);
	draw_sprite_ext(weaponSprite, 0, x, y, 1, weaponYscale, weaponAngle, c_white, 1);
	surface_reset_target();
}

draw = function() {
	var sprite = setSpriteStates();
	
	sprite_index = sprite;
	
	var surf = (drawOnSurface && surface_exists(SurfaceHandler.surface));
	
	if (surf) surface_set_target(SurfaceHandler.surface);
	
	gpu_set_fog((hitFog > 0), c_white, 0, 1);
	
	draw_self();
	
	gpu_set_fog(false, c_white, 0, 1);
	
	if (surf) surface_reset_target();
	
	weaponDraw();
}

