
// Enemy
behavior = 0;
isSolid = true;
target = Player;


var light = instance_create_depth(x, y, depth, Light);
light.intensity = 5.0;

children = new Children();
children.Append(light);

effects = [];

damage = 10;

attackOnContact = true;
ableToAttack = true;

invincible = false;

hitbox = new Dim(sprite_width, sprite_height);
drops = new DropTable();


// Movement
defaultSpd = 0.5;
spd = defaultSpd;
hsp = 0;
hspLast = 0;
vsp = 0;
hspTotal = 0;
vspTotal = 0;
knockback = new Vec2();
applyGravity = true;
applyGroundCollisions = true;
drawOnSurface = true;
onSlope = false;
stun = 0;
stunWhenHit = 0;
attacking = false;
onGround = false;

knockbackResistence = 1;

movement = function() {
	
	stun = max(0, stun - GameSpeed);
	
	if (stun > 0) {
		return;
	}
	
	// Knockback
	knockback_apply();
	
	hspTotal = hsp * knockback.x;
	vspTotal = vsp * knockback.y;
	
	x += (hspTotal) * GameSpeed;
	y += (vspTotal) * GameSpeed;
	
	if (applyGravity) vsp += Gravity;
	
	onGround = (
		place_meeting(x, y + 1, Collision) ||
		place_meeting(x, y + 1, Collision_Slope) || 
		place_meeting(x, y + 1, Collision_JumpThrough) || 
		place_meeting(x, y + 1, Collision_Rayblock)
	);
	
	if (onGround) {
		onSlope = false;
	}
	
	if (place_meeting(x, y + 1, Collision_Slope)) {
		onSlope = true;
	}
	
	if (hsp != hspLast && hsp != 0) {
		hspLast = hsp;
		if (onSlope) {
			y -= 1;
		}
	}
	
	if (onSlope) {
		hsp = round(hsp);
	}
	
	static freeSlopeTimer = 0;
	if (onSlope) {
		// check if is walking
		if (hsp != 0) {
			freeSlopeTimer += GameSpeed;
			
			if (hsp == 0 && freeSlopeTimer > 1) {
				print("Enemy: avoiding getting stuck on slope");
				y -= 1;
				freeSlopeTimer = 0;
			}
		}
	}
	
}


// Collisions
collisions = function() {
	
	if (applyGroundCollisions) {
		collision_set(Collision);
		collision_set(Collision_Slope);
		collision_set(Fakewall);
	}
	
	// Player attack 
	player_attack_check(function(a){
		if (isHit) return;
		
		var k = (0.54 * a.knockback) * knockbackResistence;
		knockback.x = a.initialDirection * (k);
		
		var critical = false;
		var criticalAmount = 1;
		critical = (irandom(10) == 10);
		
		vsp = 0;
		vsp -= a.dir.y * k;
		
		hitByPlayer = true;
		hit(a.damage * (critical + criticalAmount));
		
		// Spawn attack particle
		var pos = randvec2(x, y, 6);
		var part = instance_create_depth(pos.x, pos.y, depth, Particle_Attack);
		with (part) { self.critical = critical; }
		
		camera_shake(5, 1);
		
		// Transfer effects from players attack to the enemy
		effect_transfer(a.effects, self);
	});
	
	bound_to_room();
}


// Health
defaultHp = 100;
hp = defaultHp;
isHit = false;
hitCooldown = 0;
hitFog = 0;
destroyOnPlayerContact = false;
deathSound = choose(snd_explosion1, snd_explosion3, snd_explosion4);

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
	
	vsp -= 0.5;
	
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

drawLight = function() {
	gpu_set_blendmode(bm_add);
	draw_set_alpha(lightAlpha);

	draw_circle_color(x, y, lightLevel, lightColor, c_black, false);

	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
}

draw = function() {
	var sprite = setSpriteStates();
	
	image_speed = 1;
	if (Sleep) image_speed = 0;
	
	sprite_index = sprite;
	
	var surf = (drawOnSurface && surface_exists(SurfaceHandler.surface));
	
	if (surf) surface_set_target(SurfaceHandler.surface);
	
	gpu_set_fog((hitFog > 0), c_white, 0, 1);
	
	draw_self();
	
	gpu_set_fog(false, c_white, 0, 1);
	
	if (surf) surface_reset_target();
	
	weaponDraw();
}

