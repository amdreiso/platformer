

#region CONSOLE COMMANDS

COMMAND.register("player_set_knockback", 2, function(args) {
	try {
		var xx = real(args[0]);
		var yy = real(args[1]);
		Player.knockback = new Vec2(xx, yy);
	} catch(e) {
		err(e);
	}
});

COMMAND.register("god", 0, function(args) {
	Player.god = !Player.god;
});

COMMAND.register("player_add_effect", 2, function(args) {
	var val = real(args[0]);
	var time = real(args[1]);
	
	var effect = EFFECT.get(val);
	if (is_undefined(effect)) { 
		err("effect ID doesn't exist!");
		return;
	}
	
	effect_add(Player, val, time);
});

COMMAND.register("player_set_item", 1, function(args) {
	var val = real(args[0]);
	var item = ITEM.Get(val);
	
	if (is_undefined(item)) {
		err("Item ID does not exist!");
		return;
	}
	
	
});

#endregion


name = "player";


// Player
busy = false;
god = false;
children = [];
lightLevel = 20;
raycastCount = 180;
viewDistanceDefault = 50;
viewDistance = 50;
isVisible = true;
soul = SOUL_TYPE.Castoff;

emitter = audio_emitter_create();

effects = [];

levelTransitionCooldown = 0;

spriteStates = {
	idle: sPlayerOneEye_Idle,
	move: sPlayerOneEye_Move_1,
	attack: sPlayerOneEye_Attack,
}


#region MODULES

modules = {};
modules.list = [];
modules.has = function(val) {
	return array_contains(modules.list, val);
}
modules.add = function(val) {
	if (ITEM.GetType(val) == ITEM_TYPE.Module) {
		array_push(modules.list, val);
	}
}

modules.add(ITEM_ID.HighJumpModule);

#endregion


#region UPGRADE

PlayerUpgradeData = ds_map_create();

upgrade = {};

upgrade.list = [];

upgrade.rem = function(upgradeID) {
	for (var i = 0; i < array_length(upgrade.list); i++) {
		if (upgrade.list[i] == upgradeID) {
			array_delete(upgrade.list, i, 1);
		}
	}
}

upgrade.add = function(upgradeID) {
	for (var i = 0; i < array_length(upgrade.list); i++) {
		if (upgrade.list[i] == upgradeID) return;
	}
	
	array_push(upgrade.list, upgradeID);
	return true;
}

upgrade.register = function(upgradeID, name, icon, update, draw, drawBegin) {
	var upg = {};
	upg.name = name;
	upg.icon = icon;
	upg.update = update;
	upg.draw = draw;
	upg.drawBegin = drawBegin;
	
	PlayerUpgradeData[? upgradeID] = upg;
}

upgrade.get = function(key) {
	if (!ds_map_exists(PlayerUpgradeData, key)) return;
	return PlayerUpgradeData[? key];
}

upgrade.update = function(obj) {
	var len = array_length(upgrade.list);
	if (len == 0) return;
	
	for (var i = 0; i < len; i++) {
		var upgradeID = upgrade.list[i];
		var update = upgrade.get(upgradeID).update;
		update(obj);
	}
}

upgrade.draw = function(obj) {
	var len = array_length(upgrade.list);
	if (len == 0) return;
	
	for (var i = 0; i < len; i++) {
		var upgradeID = upgrade.list[i];
		var draw = upgrade.get(upgradeID).draw;
		draw(obj);
	}
}

upgrade.drawBegin = function(obj) {
	var len = array_length(upgrade.list);
	if (len == 0) return;
	
	for (var i = 0; i < len; i++) {
		var upgradeID = upgrade.list[i];
		var draw = upgrade.get(upgradeID).drawBegin;
		draw(obj);
	}
}


enum PLAYER_UPGRADE_ID {
	Jetpack,
}

upgrade.register(
	PLAYER_UPGRADE_ID.Jetpack, "Jetpack", -1,
	
	// Update
	function(obj){
		
		static fuelDefault = 200;
		static fuel = fuelDefault;
		
		var takeoff = 0.126;
		var key = keyboard_check(ord("S"));
		var keyPressed = keyboard_check_pressed(ord("S"));
		var keyReleased = keyboard_check_released(ord("S"));
		
		var maxFlyingSpeed = 3;
		var hasFuel = (fuel > 0)
		
		if (keyPressed && hasFuel) {
			obj.flying = true;
			obj.vsp = 0;
			obj.applyGravity = false;
		}
		
		if (keyReleased) {
			obj.flying = false;
			obj.applyGravity = true;
		}
		
		if (key && fuel > 0) {
			fuel -= GameSpeed;
			obj.vsp -= takeoff;
			//obj.vsp = clamp(obj.vsp, -maxFlyingSpeed, maxFlyingSpeed);
			
		} else {
			fuel = fuelDefault;
			
		}
		
	},
	
	// Draw
	function(obj){
		if (obj.flying) {
			//draw_sprite_ext(sPlayer_DoubleJumpFire, 0, x, bbox_bottom, 1, 1, 0, c_white, 1);
		}
	},
	
	// Draw begin
	function(obj){
		var spr = sPlayerUpgrade_Jetpack;
		draw_sprite_ext(spr, 0, x, y, image_xscale, image_yscale, angle, c_white, 1);
		
	},
	
);


upgrade.add(PLAYER_UPGRADE_ID.Jetpack);

#endregion


#region MAP

function MapTile(roomID, x, y, color, passages = {}) constructor {
	self.roomID = roomID;
	self.x = x;
	self.y = y;
	self.passages = {
		down: false,
		up: false,
		right: false,
		left: false,
	};
	
	var transitions = LEVEL.Get(roomID).components.transitions;
	var len = array_length(transitions);
	
	for (var i = 0; i < len; i++) {
		var t = transitions[i];
		var xx, yy;
		xx = t.x div ROOM_TILE_WIDTH;
		yy = t.y div ROOM_TILE_HEIGHT;
		
		var playerInTile = (Player.tilePosition.x == xx && Player.tilePosition.y == yy);
		
		if (variable_struct_exists(self.passages, t.side) && playerInTile && !t.isHidden) {
			variable_struct_set(self.passages, t.side, true);
		}
	}
	
}

map = {
	open: false,
	size: 20,
	grid: [],
	
	discover: function(roomID, x, y, color=c_blue) {
		var tile = new Player.MapTile(roomID, x, y, color);
		array_push(Player.map.grid, tile);
	},
	
	draw: function() {
		if (!Player.map.open) return;
		
		draw_set_alpha(0.5);
		draw_rectangle_color(0, 0, WIDTH, HEIGHT, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		
		var pos = new Vec2(
			100, HEIGHT / 2
		);
		
		for (var i = 0; i < array_length(grid); i++) {
			
			var g = grid[i];
			var size = Player.map.size;
			
			var level = LEVEL.Get(g.roomID);
			var roomOffsetX = level.components.mapOffsetPos.x;
			var roomOffsetY = level.components.mapOffsetPos.y;
			
			var padding = 1.05;
			
			var xx = floor(pos.x + (g.x * size * padding) + roomOffsetX * size);
			var yy = floor(pos.y + (g.y * size * padding) + roomOffsetY * size);
			
			var c0 = make_color_hsv(140, 255, 230);
			var c1 = c_white;
			var c2 = c_black;
			
			c0 = level.components.mapTileColor;
			
			draw_rectangle_color(
				xx, yy,
				xx + size, yy + size,
				c0, c0, c0, c0, false
			);
			
			// Draw passages
			var p = g.passages;
			var pc = c_black;
			var pw = 2;
			
			//if (p.down) {
			//	draw_line_width_color(xx, yy + size, xx + size / 3, yy + size, pw, pc, pc);
			//	draw_line_width_color(xx + size, yy + size, (xx + size) - size / 3, yy + size, pw, pc, pc);
				
			//} else if (p.right) {
				
				
			//}
			
			
			if (Player.lastChunk.x == g.x && Player.lastChunk.y == g.y && room == g.roomID) {
				draw_set_alpha(0.5);
				draw_rectangle_color(
					xx, yy,
					xx + size, yy + size,
					c2, c2, c2, c2, false
				);
				draw_set_alpha(1);
				
				draw_rectangle_color(
					xx, yy,
					xx + size, yy + size,
					c0, c1, c0, c1, true
				);
			
				var scale = 1;
				draw_sprite_ext(sPlayerOneEye_Idle, 0, xx + size / 2, yy + size / 2, scale, scale, 0, c_white, 1);
			}
			
		}
	},
}

#endregion


#region STATS

luck = 1;
intelligence = 1;

mana = new Stat(10);
manaDisplay = mana.defaultValue;

#endregion


#region HEALTH

hp = new Stat(100);
hpDisplay = hp.defaultValue;

hitCooldown = 0;
resetPosition = false;
resetPositionTick = 0
resetPositionTime = 0.33 * 60;
isDead = false;
isHit = false;

setHp = function(value) {
	hp.UpdateValue(value);
}

handleHealth = function() {
	hitCooldown = max(0, hitCooldown - GameSpeed);
	if (hitCooldown == 0) isHit = false;
	isDead = (hp.value <= 0);
	
	resetPositionTick += GameSpeed;
	
	if (resetPosition && resetPositionTick >= resetPositionTime) {
		x = lastPlaceStanding.x;
		y = lastPlaceStanding.y - 2;
		image_xscale = lastPlaceStanding.image_xscale;
		
		resetPositionTick = 0;
		resetPosition = false;
	}
}

hit = function(damage, xscale=1, applyKnockback = true, stun = true) {
	if (isHit || god || isDead) return;
	
	var cooldown = 50;
	if (!stun) then cooldown = 1;
	
	var defense = 1;
	//if (inventory.equipment[PLAYER_EQUIPMENT_ID.Armor].itemID != -1) {
	//}
	
	var damageValue = ceil(damage * defense);
	
	hp.Sub( damageValue );					// Always round up so taking 0.0001 damage isn't possible
	isHit = true;
	hitCooldown = cooldown;
	
	create_popup_particle(damageValue);
	
	if (stun) {
		hsp = 0;
		vsp = 0;
	}
	
	if (applyKnockback) {
		var multiplier = new Vec2(0.15, 1);
		
		knockback.y -= (jumpForce * multiplier.y) * !onAir;
		
		if (xscale == 0) xscale = choose(-1, 1);
		knockback.x = xscale * multiplier.x;
	}
	
	
	// Screen effects
	var shake = clamp(damage / 0.5, 0, 4);
	
	camera_shake(shake);
	
	Screen.flash(0.5, 0.05, c_white);
	
	
	// Sounds
	var hitSound = choose(snd_hit1, snd_hit2);
	audio_play_sound(hitSound, 0, false, 0.5, 0, random_range(0.80, 1.00));
}


dieByContact = function() {
	if (resetPosition) return;
	
	resetPosition = true;
	resetPositionTick = 0;
	
	hit(10);
	
	knockback = new Vec2();
}

#endregion


#region MOVEMENT

allowMovement						= true;
defaultSpd							= 1.44;
spd											= defaultSpd;
hsp											= 0;
vsp											= 0;
hspLast									= 0;
hspFrac									= 0;
vspFrac									= 0;
force										= new Vec2();
jumpForce								= 1.66;
jumpCountDefault				= 1;
jumpCount								= jumpCountDefault;
isJumping								= false;
onGround								= false;
onAir										= false;
onSlope									= false;
isMoving								= false;
isFlipping							= false;
hasFlipped							= false;
noclip									= false;
lastPlaceStanding				= undefined;
applyGravity						= true;
jumpThroughGracePeriod	= 0;
knockback								= new Vec2();
impact									= false;
impactTimer							= 0;
lastChunk								= { roomID: -1, x: 0, y: 0 };
secondJumpTick					= 0;
flying									= false;
tilePosition						= new Vec2();

halt = function() {
	hsp = 0;
	vsp = 0;
	knockback = new Vec2();
}

getPosition = function() {
	return new Vec2(x, y);
}

flip = function() {
	isFlipping = true;
	angle = image_xscale * 5;
	hasFlipped = true;
}

handleBackflip = function() {
	if (!isFlipping || busy) return;
	
	var time = 360 / 45;
	angle = (angle + (time * GameSpeed) * -image_xscale);
	
	if (abs(angle) >= 355) { 
		angle = 0; 
		isFlipping = false; 
	}
}

getLastStandingPosition = function() {
	var pos = {};
	
	pos.x = x;
	pos.y = y;
	pos.image_xscale = image_xscale;
	
	return pos;
}

movement = function() {
	if (busy) return;
	
	// keymap
	var map = Keymap.player;
	
	
	// Knockback
	knockback_apply();
	
	isMoving = (hsp != 0 || vsp != 0);
	applyGravity = (!place_meeting(x, y + 1, Elevator));
	
	spd = defaultSpd;
	
	var wasOnGround = onGround;
	onGround = (
		place_meeting(x, y + 1, Collision) ||
		place_meeting(x, y + 1, Collision_Slope) || 
		place_meeting(x, y + 1, Collision_JumpThrough) || 
		place_meeting(x, y + 1, Collision_Rayblock)
	);
	
	onAir = !onGround;
	
	impact = false;
	
	if (onGround && !wasOnGround && !onSlope) {
		jumpThroughGracePeriod = 0;
		createDustParticles(10, 5, 0.20);
		impact = true;
	}
	
	if (onGround) {
		onSlope = false;
		jumpCount = jumpCountDefault;
		isFlipping = false;
		hasFlipped = false;
		
		isJumping = false;
		
		if (!place_meeting(x, y + 1, Collision_JumpThrough)) {
			lastPlaceStanding = getLastStandingPosition();
		}
	}
	
	var wasOnSlope = onSlope;
	if (place_meeting(x, y + 1, Collision_Slope)) {
		onSlope = true;
	}
	
	// Push the player's y position up by a pixel so it doesnt get stuck on turns on slopes
	//if (hsp != hspLast && hsp != 0) {
	//	hspLast = hsp;
	//	if (onSlope) {
	//		y -= 1;
	//		print("Player: avoiding getting stuck on slope");
	//	}
	//}
	
	
	// check if player is stuck on slope and free him
	static freeSlopeTimer = 0;
	if (onSlope) {
		// check if is walking
		if (map.left || map.right) {
			freeSlopeTimer += GameSpeed;
			
			if (hsp == 0 && freeSlopeTimer > 1) {
				print("Player: avoiding getting stuck on slope");
				y -= 1;
				freeSlopeTimer = 0;
			}
		}
	}
	
	var hspMultiplier = 1;
	
	if (isAttacking && onGround) {
		hspMultiplier = 0;
	}
	
	
	hsp += knockback.x;
	vsp += knockback.y;
	
	x += ((hsp) * GameSpeed) * hspMultiplier;
	y += (vsp) * GameSpeed;
	
	
	// max falling speed
	vsp = clamp(vsp, -MAX_FALLING_SPEED, MAX_FALLING_SPEED);
	
	
	// gravity
	if (applyGravity) {
		vsp += Gravity * GameSpeed;
	}
	 
	
	if (hsp != 0) {
		if (keyboard_check_pressed(ord("B"))) {
			knockback.x += 4 * sign(hsp);
		}
	}
	
	
	// if on cutscene disable movement
	var skipMovement = (OnCutscene);
	if (skipMovement) return;
	
	var left = map.left;
	var right = map.right;
	var jump = map.jump;
	
	var dir = point_direction(0, 0, right - left, 0);
	var len = (right - left != 0);
	
	// Walk horizontally only when not hit
	if (!isHit) {
		hsp = lengthdir_x(spd * len, dir);
		
	}
	else if (isHit) {
		hsp += knockback.x;
		
	}
	
	// Jump
	if (map.downPressed) {
		jumpThroughGracePeriod = 15;
	}
	
	if (onAir) {
		secondJumpTick += GameSpeed;
	} else {
		secondJumpTick = 0;
	}
	
	var jumpCondition = (jumpCount > 0 /* && impactTimer == 0 */ && secondJumpTick < 40 && !flying);
	
	if (map.jump && jumpCondition) {
		vsp = 0;
		vsp -= jumpForce;
		
		onSlope = false;
		
		if (onGround) {
			createDustParticles(10, 5);
		}
		
		if (jumpCount == jumpCountDefault) {
			secondJumpTick = 0;
			flip();
		}
		
		jumpCount --;
		isJumping = true;
	}
	
	// Relative jump
	if (vsp < 0 && !map.jumpHold && !map.useItem) {
		vsp = max(vsp, -0.25);
	}
	
	// Dash
	//dash();
	
	// Noclip
	if (noclip) {
		vsp = 0;
		x = mouse_x;
		y = mouse_y;
	}
	
	if (onSlope) {
		hsp = round(hsp);
	}
	
}

//dash = function() {
//	if (keyboard_check_pressed(vk_shift)) {
//		force.x = sign(hsp) * 2;
//	}
//}

#endregion


#region PARTICLES

createDustParticles = function(val, range, spd = 0.15) {
	repeat (val) {
		var pos = randvec2(x, y + sprite_height / 2, range);
		
		var part = instance_create_depth(pos.x, pos.y, depth, Particle);
		with (part) {
			
			gravityApply = false;
			
			var dir = spd;
			hsp = random_range(-dir, dir);
			vsp = random_range(-dir, dir);
			
			sprite = sParticle_Dust;
			randomSprite = true;
			
			scale = random_range(1.00, 1.50);
			scaleFactor = random_range(-0.01, -0.10) / 4;
			
			image_angle = irandom(360);
			image_xscale = choose(-1, 1);
			image_yscale = choose(-1, 1);
			
			fadeout = true;
			fadeoutSpeed = random_range(0.05, 0.15) / 5;
		}
	}
}

#endregion


#region COLLISIONS


collisionMask = instance_create_depth(x, y, depth, PlayerCollision);

collision = new Callback();

applyCollisions = function() {
	if (noclip) return;
	
	
	// Player Collision Mask
	if (!instance_exists(PlayerCollision)) {
		
		collisionMask = instance_create_depth(x, y, depth, PlayerCollision);
		
	} else {
	
		with (collisionMask) {
			// Make collision object follow the player
			self.x = other.x;
			self.y = other.y;
			
			if (place_meeting(x, y, Collision_Death)) {
				Player.dieByContact();
				
			}
			
			if (place_meeting(x, y, Trigger)) {
				instance_destroy(instance_nearest(x, y, Trigger));
			}
	
			if (place_meeting(x, y, ProjectileEnemy)) {
				var proj = instance_nearest(x, y, ProjectileEnemy);
				
				if (!proj.used) {
					var xdir = sign(x - proj.shooter.x);
					if (xdir == 0) xdir = choose(1, -1);
		
					other.hit(proj.damage, xdir);
		
					if (proj.destroyOnContact) {
						instance_destroy(proj);
					}
				}
			}
	
			if (place_meeting(x, y, Enemy)) {
				var enemy = instance_nearest(x, y, Enemy);
				var xdir = sign(x - enemy.x);
				if (xdir == 0) xdir = choose(1, -1);
				
				if (enemy.attackOnContact && enemy.ableToAttack) other.hit(enemy.damage, xdir);
			}
			
			other.collision.Run(other);
		}
	}
	
	
	jumpThroughGracePeriod = max(0, jumpThroughGracePeriod - 1);
	
	var jumpThrough = instance_place(x, y + max(1, vsp), Collision_JumpThrough);
	if (jumpThrough && floor(bbox_bottom) <= jumpThrough.bbox_top && jumpThroughGracePeriod == 0) {
		if (vsp > 0) {
			while (!place_meeting(x, y + sign(vsp), Collision_JumpThrough)) {
				y += sign(vsp);
			}
			
			vsp = 0;
		}
	}
	
	collision_set(Collision, spd);
	collision_set(Collision_Slope, spd);
	collision_set(Collision_Rayblock, spd);
	collision_set(Fakewall, spd);
	
	
	if (instance_exists(DoorSideways)) {
		var doorside = instance_nearest(x, y, DoorSideways);
		if (!doorside.open) {
			collision_set(doorside);
		}
	}
}

#endregion


#region CARRYING

isCarrying = false;
carrying = noone;

pickCarriable = function(obj) {
	if (isCarrying) return;
	carrying = obj;
}

dropCarriable = function() {
	if (!isCarrying) return;
	
	carrying.vsp -= 1;
	carrying = noone;
}

applyCarriable = function() {
	isCarrying = (carrying != noone);
	
	if (!isCarrying) return;
	
	carrying.y = bbox_top;
	carrying.x = x;
	
	carrying.vsp = 0;
	
	if (Keymap.player.interact) {
		dropCarriable();
	}
}

// Collision
collision.Register(function(obj){
	if (place_meeting(x, y, Carriable)) {
		if (Keymap.player.interact) {
			Player.carrying = instance_nearest(x, y, Carriable);
		}
	}
});

#endregion


#region ATTACK

subitem_init();
subitem = SUBITEM_ID.WaterBucket;

isAttacking = false;

attackCommandInput = "";
attackCommandTimer = 0;

attackCommands = ds_map_create();
attackCommandCreate = function(key, name="", fn=function(){}) {
	var command = {};
	command.run = fn;
	command.name = name;
	attackCommands[? key] = command;
}

attackCommandGet = function(key) {
	return attackCommands[? key];
}

#region All attack commands

// controls:
// down up right left attack jump

// High Jump
attackCommandCreate("down+up+jump", "big jump!", function(){
	if (!onGround) return false;
	if (!modules.has(ITEM_ID.HighJumpModule)) return false;
	
	vsp = 0;
	vsp -= 3;
	return true;
});

attackCommandCreate("left+down+right+up+down+jump", "", function(){
	if (!onGround) return;
});


#endregion



// ↑ ↓ → ←

analogPressed = false;

attack = function() {
	if (busy || isAttacking) return;
	if (instance_exists(Cutscene)) return;
	
	var handID = inventory.equipment.sword.itemID;
	var hand = inventory.equipment.sword.Get();
	var handType = inventory.equipment.sword.GetType();
	
	// Sword attack
	if (Keymap.player.attack && handType == ITEM_TYPE.Sword) {
		
		print($"Player attacked with '{TRANSLATION.Get(handID, -1)}'");
		
		/*
		TODO: 
		make every sword attack sprite unique
		*/
		
		var atk = instance_create_depth(x, y, depth, PlayerAttack);
		
		atk.sprite_index = hand.components.attackSprite;
		atk.image_xscale = image_xscale;
		atk.initialDirection = image_xscale;
		
		atk.damage = hand.components.damage;
		
		inventory.equipment.sword.spell.Apply(atk);
		
		var hdir = image_xscale;
		var vdir = (Keymap.player.jumpHold && onGround);
		
		if (vdir && hsp == 0) then hdir = 0;
		
		atk.dir = new Vec2(hdir, vdir);
		
		isAttacking = true;
	}
	
	var map			= Keymap.player;
	var keycode = "";
	var lastkey = "";
	
	var clicky = false;
	
	// Controller Analog
	if (gamepad_axis_value(Gamepad.ID, gp_axislh) == -1 && !analogPressed) {
		keycode = "left";
		clicky = true;
		analogPressed = true;
		
	} else if (gamepad_axis_value(Gamepad.ID, gp_axislh) == 1 && !analogPressed) {
		keycode = "right";
		clicky = true;
		analogPressed = true;
		
	} else if (gamepad_axis_value(Gamepad.ID, gp_axislv) == -1 && !analogPressed) {
		keycode = "up";
		clicky = true;
		analogPressed = true;
		
	} else if (gamepad_axis_value(Gamepad.ID, gp_axislv) == 1 && !analogPressed) {
		keycode = "down";
		clicky = true;
		analogPressed = true;
		
	}
	
	if (
		gamepad_axis_value(Gamepad.ID, gp_axislh) > -1 &&
		gamepad_axis_value(Gamepad.ID, gp_axislh) < 1 &&
		gamepad_axis_value(Gamepad.ID, gp_axislv) > -1 &&
		gamepad_axis_value(Gamepad.ID, gp_axislv) < 1
	) {
		analogPressed = false;
	}
	
	
	// Buttons
	if (map.upPressed) {
		keycode = "up";
		clicky = true;
		
	} else if (map.downPressed) {
		keycode = "down";
		clicky = true;
		
	} else if (map.leftPressed) {
		keycode = "left";
		clicky = true;
		
	} else if (map.rightPressed) {
		keycode = "right";
		clicky = true;
		
	} else if (map.attack) {
		keycode = "attack";
		clicky = true;
		
	} else if (map.jump) {
		keycode = "jump";
		clicky = true;
	}
	
	
	// run combo mechanic
	if (clicky) {
		var prefix = "";
		
		if (keycode == 32) keycode = 90;
		
		// If there is content in the command input
		if (attackCommandInput != "") {
			prefix = "+"; 
			var slices = string_split(attackCommandInput, "+");
			lastkey = slices[array_length(slices) - 1];
			
		} else {
			prefix = "";
			
		}
		
		attackCommandInput += prefix + keycode;
		
		var command = attackCommandGet(attackCommandInput);
		if (!is_undefined(command)) {
			if (command.run()) then print($"Player executed command '{command.name}'");
			attackCommandInput = "";
		}
		
		attackCommandTimer = 0;
	}
	
	// Reset combo thingy	
	attackCommandTimer += GameSpeed;
	if (attackCommandTimer > PLAYER_COMMAND_INPUT_TIMER) attackCommandInput = "";
	
	
	// handle weapons
	
	//if (Keymap.player.attack && ITEM.getType(hand) == ITEM_TYPE.Weapon) {
	//}
}

#endregion


#region INVENTORY

#macro ITEM_STACK 10

inventory = new Inventory(8, 4);
inventoryOpen = false;

inventory.Add(ITEM_ID.BaseballBat);
inventory.Add(ITEM_ID.DevStick);
inventory.Add(ITEM_ID.FlameSpell);
inventory.Add(ITEM_ID.FreezeSpell);
inventory.Add(ITEM_ID.Jetpack);
inventory.Add(ITEM_ID.KnockbackSpell);
inventory.Add(ITEM_ID.PoisonSpell);
inventory.Add(ITEM_ID.ScrapElectronics);
inventory.Add(ITEM_ID.StrengthSpell);

enum PLAYER_EQUIPMENT_ID {
	Hand,
	Offhand,
	Armor,
	Count,
}

//inventory.equipment = {
//	hand: new Tool(ITEM_ID.DevStick),
//	offhand: new Tool(ITEM_ID.BaseballBat),
//	armor: new Armor(ITEM_ID.Armor),
//};

inventory.equipment.sword.Set(ITEM_ID.DevStick);
inventory.equipment.sword.spell.Add(SPELL_ID.Flames);


#endregion


#region DRAW

angle = 0;

blink = false;
playerShadowColor = c_dkgray;

color = c_white;

shadow = ds_list_create();

// Draw Function
draw = function() {
	if (!isVisible) return;
	
	// Set sprite speed
	image_speed = GameSpeed;
	
	var sprite = spriteStates.idle;
	
	// Move when walking horizontally
	if (hsp != 0 && !isAttacking) {
		sprite = spriteStates.move;
		
		if (!isHit) image_xscale = sign(hsp);
	}
	
	// If player is busy idle
	if (busy) {
		sprite = spriteStates.idle;
	}
	
	// Attack sprite
	if (isAttacking) {
		sprite = spriteStates.attack;
		
		// Stop attacking sprite when sprite animation ends
		on_last_frame(function(){
			if (sprite_index != spriteStates.attack) return;
			isAttacking = false;
		});
	}
	
	// Angle if hit
	if (isHit) {
		angle = 27 * sign(hsp);
	}
	
	// Upon impact
	if (impact) {
		impactTimer = 15;
		isAttacking = false;
	}
	
	if (impactTimer > 0 && !onSlope) {
		impactTimer = max(0, impactTimer - GameSpeed);
		sprite = sPlayerOneEye_Impact;
	}
	
	sprite_index = sprite;
	
	if (onGround || onSlope) {
		angle = angle_lerp(angle, 0, 0.25);
	}
	
	
	if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);
	
	// Blink sprite when hit
	if (hitCooldown % 5 == true) {
		blink = !blink;
	}
	
	
	// Draw Trail
	if (Settings.graphics.playerTrail) {
	
		static shdTick = 0;
		shdTick ++;
		if (shdTick >= 2) {
			var shd = {};
			shd.sprite = sprite;
			shd.index = image_index;
			shd.x = x;
			shd.y = y;
			shd.xscale = image_xscale;
			shd.yscale = image_yscale;
			shd.angle = angle;
			shd.decrease = 0.075;
			shd.time = 0.88;
			shd.color = choose(c_orange);
			ds_list_add(shadow, shd);
		
			shdTick = 0;
		}
	
		for (var i = 0; i < ds_list_size(shadow); i++) {
			var key = ds_list_find_value(shadow, i);
		
			if (key.time <= 0) {
				ds_list_delete(shadow, i);
			}
		
			key.time -= key.decrease * GameSpeed;
		
			gpu_set_fog(true, key.color, 0, 1);
			draw_sprite_ext(key.sprite, key.index, key.x, key.y, key.xscale, key.yscale, key.angle, c_white, key.time);
			gpu_set_fog(false, c_white, 0, 1);
		}
	}
	
	if (Sleep) {
		image_speed = 0;
	}
	
	// Draw player sprite
	if (hitCooldown == 0 || !blink) {
		//draw_outline(1, angle, Style.outlineColor);
		
		var xoffset = 2 * image_xscale;
		var yoffset = 1 * image_yscale;
		
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, color, 1);
	}
	
	//if (jumpCount < jumpCountDefault) {
	//	draw_sprite_ext(sPlayer_DoubleJumpFireы, -1, x, y + sprite_height / 2, image_xscale, 1, sin(current_time * 0.001) * 0.5, c_white, 1);
	//}
	
	if (surface_exists(SurfaceHandler.surface)) surface_reset_target();
	
	if (!Settings.graphics.enableSurfaces) {
		
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, color, 1);
	}
}

#endregion


#region DRAW GUI

drawGUI = function() {
	if (Paused) return;
	
	var guiScale = Style.guiScale / 2;
	var guiScale = 3;
	
	
	var margin = 10 * guiScale;
	
	
	if (hpDisplay > hp.value) {
		hpDisplay = lerp(hpDisplay, hp.value, 0.25);
	}
	
	var maxHpDisplay = 20;
	var hpPart = (hpDisplay / hp.defaultValue);
	var manaPart = (manaDisplay / mana.defaultValue);
	
	for (var i = 0; i < maxHpDisplay; i++) {
		var xoffset = margin;
		var width = (sprite_get_width(sHealthBar) * guiScale);
		
		var color = c_white;
		
		var sprite = sHealthBar;
		var index = 0;
		if (i == 0) index = 2;
		if (i == maxHpDisplay - 1) index = 1;
		
		if (i >= ceil(maxHpDisplay * hpPart)) color = c_dkgray;
		
		draw_sprite_ext(sprite, index, xoffset + i * width, margin, guiScale, guiScale, 0, color, 1);
	}
	
	for (var i = 0; i < maxHpDisplay; i++) {
		var xoffset = margin;
		var width = (sprite_get_width(sManaBar) * guiScale);
		
		var color = c_white;
		
		var sprite = sManaBar;
		var index = 0;
		if (i == 0) index = 2;
		if (i == maxHpDisplay - 1) index = 1;
		
		if (i >= ceil(maxHpDisplay * manaPart)) color = c_dkgray;
		
		draw_sprite_ext(sprite, index, xoffset + i * width, margin + sprite_get_height(sManaBar) * guiScale * 1.25, guiScale, guiScale, 0, color, 1);
	}
	
	
}


labelBackgroundX = 0;

secret = false;
secretTime = 0;
secretAlpha = 0;

drawSecretGUI = function() {
	var lerpTime = 0.05;
	
	if (!secret) return;
	
	rect(WIDTH / 2, HEIGHT / 2, labelBackgroundX, 80, c_black, false, 0.35);
	
	var str = "[scale=3]you've found a [color=#ff5555]secret![/color][/scale]";
	var text = parse_rich_text(str);
	
	var totalWidth = 0;
	var len = array_length(text);
	
	for (var i = 0; i < len; i++) {
		var tc = text[i];
	  totalWidth += string_width(tc.char) / tc.scale * tc.scale;
	}
	
	var xoffset = -totalWidth / 2;
	
	for (var i = 0; i < len; i++) {
		var tc = text[i];
	  
	  var dx = WIDTH / 2 + xoffset * tc.scale;
	  var dy = HEIGHT / 2;
    
	  dx += random_range(-tc.shake, tc.shake);
	  dy += random_range(-tc.shake, tc.shake);
		
		draw_set_font(fnt_console);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
	  draw_text_transformed_color(dx, dy, tc.char, tc.scale, tc.scale, tc.angle, tc.color, tc.color, tc.color, tc.color, secretAlpha);
	  xoffset += string_width(tc.char);
	}
	
	secretTime += GameSpeed * !Paused;
	if (floor(secretTime) > 4 * 60) {
		secretAlpha = lerp(secretAlpha, 0, lerpTime);
		labelBackgroundX = lerp(labelBackgroundX, 0, 0.1);
		
	} else {
		secretAlpha = lerp(secretAlpha, 1, lerpTime);
		labelBackgroundX = lerp(labelBackgroundX, WIDTH, 0.1);
		
	}
	
	if (secretAlpha < 0.01) {
		secret = false;
		secretTime = 0;
	}
}

// Death screen
deathScreenAlpha = 0;

drawDeathScreen = function() {
	
	deathScreenAlpha = lerp(deathScreenAlpha, isDead, 0.025);
	
	var a = deathScreenAlpha;
	var c0 = c_black;
	
	draw_set_alpha(a / 2);
	draw_rectangle_color(0, 0, WIDTH, HEIGHT, c0, c0, c0, c0, false);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var messageScale = 2;
	
	draw_text_transformed(WIDTH / 2, HEIGHT / 2, TRANSLATION.Get("gui_death_screen_message"), messageScale, messageScale, 0);
	
	draw_set_alpha(1);
	
}

#endregion




