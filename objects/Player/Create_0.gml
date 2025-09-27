

#region Console Commands

COMMAND.register("player_set_knockback", 2, function(args) {
	try {
		var xx = real(args[0]);
		var yy = real(args[1]);
		Player.knockback = vec2(xx, yy);
	} catch(e) {
		err(e);
	}
});

COMMAND.register("god", 0, function(args) {
	Player.god = !Player.god;
});

#endregion


name = "player";


// Player
busy = false;
god = false;
children = [];
lightLevel = 20;
isSolid = true;
raycastCount = 180;
viewDistanceDefault = 50;
viewDistance = 50;
isVisible = true;

emitter = audio_emitter_create();

soul = SOUL_TYPE.Castoff;

collisionMask = instance_create_depth(x, y, depth, PlayerCollision);



// Upgrades
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

upgrade.register = function(upgradeID, name, icon, update, draw) {
	var upg = {};
	upg.name = name;
	upg.icon = icon;
	upg.update = update;
	upg.draw = draw;
	
	PlayerUpgradeData[? upgradeID] = upg;
}

upgrade.get = function(key) {
	if (!ds_map_exists(PlayerUpgradeData, key)) return;
	return PlayerUpgradeData[? key];
}

upgrade.update = function() {
	var len = array_length(upgrade.list);
	if (len == 0) return;
	
	for (var i = 0; i < len; i++) {
		var upgradeID = upgrade.list[i];
		var update = upgrade.get(upgradeID).update;
		update(Player);
	}
}

upgrade.draw = function() {
	var len = array_length(upgrade.list);
	if (len == 0) return;
	
	for (var i = 0; i < len; i++) {
		var upgradeID = upgrade.list[i];
		var draw = upgrade.get(upgradeID).draw;
		draw(Player);
	}
}


#region Upgrades

enum PLAYER_UPGRADE_ID {
	Jetpack,
}

upgrade.register(
	PLAYER_UPGRADE_ID.Jetpack, "Jetpack", -1,
	
	function(obj){
		
		static fuelDefault = 200;
		static fuel = fuelDefault;
		
		var takeoff = 1.026;
		var key = keyboard_check(ord("S"));
		var keyPressed = keyboard_check_pressed(ord("S"));
		var keyReleased = keyboard_check_released(ord("S"));
		
		var maxFlyingSpeed = 3;
		
		if (keyPressed) {
			obj.flying = true;
		}
		
		if (keyReleased) {
			obj.flying = false;
		}
		
		if (key && fuel > 0) {
			fuel -= GameSpeed;
			obj.vsp = 0;
			obj.knockback.y -= takeoff;
			
			obj.knockback.y = clamp(obj.knockback.y, -maxFlyingSpeed, maxFlyingSpeed);
			
		} else {
			fuel = fuelDefault;
			
		}
		
	},
	
	function(){
		
	}
);

#endregion

upgrade.add(PLAYER_UPGRADE_ID.Jetpack);




// Map
function MapTile(roomID, x, y) constructor {
	self.roomID = roomID;
	self.x = x;
	self.y = y;
}

map = {
	open: false,
	size: 20,
	grid: [],
	
	discover: function(roomID, x, y) {
		var tile = new MapTile(roomID, x, y);
		array_push(Player.map.grid, tile);
	},
	
	draw: function() {
		if (!Player.map.open) return;
		
		draw_set_alpha(0.5);
		draw_rectangle_color(0, 0, WIDTH, HEIGHT, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		
		var pos = vec2(
			100, HEIGHT / 2
		);
		
		for (var i = 0; i < array_length(grid); i++) {
			
			var g = grid[i];
			var size = Player.map.size;
			
			var level = LEVEL.get(g.roomID);
			var roomOffsetX = level.components.mapOffsetPos.x;
			var roomOffsetY = level.components.mapOffsetPos.y;
			
			var padding = 1.05;
			
			var xx = floor(pos.x + (g.x * size * padding) + roomOffsetX * size);
			var yy = floor(pos.y + (g.y * size * padding) + roomOffsetY * size);
			
			var c0 = make_color_hsv(140, 255, 230);
			var c1 = c_white;
			var c2 = c_black;
			
			draw_rectangle_color(
				xx, yy,
				xx + size, yy + size,
				c0, c0, c0, c0, false
			);
			
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


// Stats
damage = 10;
defense = 0;
luck = 0;
intelligence = 0;
mana = 100;


// Health
hp = new Stat(200);
hpDisplay = hp.defaultValue;

hitCooldown = 0;
resetPosition = false;
resetPositionTick = 0
resetPositionTime = 0.33 * 60;
isDead = false;
isHit = false;

setHp = function(value) {
	hp.updateValue(value);
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

hit = function(damage, xscale=1) {
	if (isHit || god) return;
	
	hp.sub(damage);
	isHit = true;
	hitCooldown = 50;
	
	hsp = 0;
	vsp = 0;
	knockback.y -= (jumpForce * 4) * !onAir;
	
	if (xscale == 0) xscale = choose(-1, 1);
	knockback.x = xscale * 2;
	
	var shake = clamp(damage / 0.5, 0, 4);
	
	screen_flash(0.3, 0.06, c_red);
	camera_shake(shake);
	
	var hitSound = choose(snd_hit1, snd_hit2);
	audio_play_sound(hitSound, 0, false, 0.5, 0, random_range(0.80, 1.00));
}


dieByContact = function() {
	if (resetPosition) return;
	
	resetPosition = true;
	resetPositionTick = 0;
	
	hit(10);
	
	knockback = vec2();
}



// Movement
allowMovement						= true;
defaultSpd							= 1.33;
spd											= defaultSpd;
hsp											= 0;
vsp											= 0;
hspLast									= 0;
hspFrac									= 0;
vspFrac									= 0;
force										= vec2();
jumpForce								= 1.66;
jumpCountDefault				= 1;
jumpCount								= jumpCountDefault;
isJumping								= false;
onGround								= false;
onAir										= false;
onSlope									= false;
isMoving								= false;
isFlipping							= false;
noclip									= false;
lastPlaceStanding				= undefined;
applyGravity						= true;
jumpThroughGracePeriod	= 0;
knockback								= vec2();
impact									= false;
impactTimer							= 0;
lastChunk								= { roomID: -1, x: 0, y: 0 };
secondJumpTick					= 0;
flying									= false;


getPosition = function() {
	return vec2(x, y);
}

flip = function() {
	isFlipping = true;
	angle = image_xscale * 5;
}

handleBackflip = function() {
	if (!isFlipping) return;
	
	var time = 360 / 45;
	angle = angle + (time) * -image_xscale;
	
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
	
	// Knockback
	if (round(knockback.x) != 0) knockback.x += ( -sign(knockback.x) * GameSpeed ); else knockback.x = 0;
	if (round(knockback.y) != 0) knockback.y += ( -sign(knockback.y) * GameSpeed ); else knockback.y = 0;
	
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
	if (hsp != hspLast && hsp != 0) {
		hspLast = hsp;
		if (onSlope) {
			y -= 1;
			print("Player: avoiding getting stuck on slope");
		}
	}
	
	var hspMultiplier = 1;
	
	if (isAttacking && onGround) {
		hspMultiplier = 0;
	}
	
	x += (hsp + knockback.x) * hspMultiplier;
	y += (vsp + knockback.y);
	
	
	// gravity
	if (applyGravity) vsp = (vsp + Gravity) * GameSpeed;
	
	apply_force();
	
	
	// max falling speed
	vsp = clamp(vsp, -MAX_FALLING_SPEED, MAX_FALLING_SPEED);
	
	// if on cutscene disable movement
	var skipMovement = (OnCutscene);
	if (skipMovement) return;
	
	var map = Keymap.player;
	var left = map.left;
	var right = map.right;
	var jump = map.jump;
	
	var dir = point_direction(0, 0, right - left, 0);
	var len = (right - left != 0);
	
	// Walk horizontally only when not hit
	if (!isHit) {
		hsp = lengthdir_x(spd * len, dir) * GameSpeed;
		
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
	
	var jumpCondition = (jumpCount > 0 /* && impactTimer == 0 */ && secondJumpTick < 40);
	
	if (map.jump && jumpCondition) {
		vsp = 0;
		vsp -= jumpForce;
		
		onSlope = false;
		
		if (onGround) {
			createDustParticles(10, 5);
		}
		
		if (jumpCount == jumpCountDefault) {
			secondJumpTick = 0;
		}
		
		jumpCount --;
		isJumping = true;
	}
	
	// Relative jump
	if (vsp < 0 && !map.jumpHold) {
		vsp = max(vsp, -0.25);
	}
	
	// Dash
	dash();
	
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

dash = function() {
	if (keyboard_check_pressed(vk_shift)) {
		force.x = sign(hsp) * 2;
	}
}


// Particles
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
			getRandomSprite = true;
			
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



// Collisions
//collisionTilemap = layer_tilemap_get_id("Collision_Map");


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
		
				if (enemy.attackOnContact) other.hit(enemy.damage, xdir);
			}
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
	collision_set(FakeWall, spd);
	
	
	if (instance_exists(DoorSideways)) {
		var doorside = instance_nearest(x, y, DoorSideways);
		if (!doorside.open) {
			collision_set(doorside);
		}
	}
}


// Attack
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

// Big Jump
attackCommandCreate("down+up+jump", "big jump!", function(){
	if (!onGround) return;
	vsp = 0;
	vsp -= 3;
});

attackCommandCreate("left+down+right+up+down+jump", "", function(){
	if (!onGround) return;
});

#region front-flip

attackCommandCreate("left+jump+up+jump", "front-flip", function(){
	if (onGround) return;
	flip();
});

attackCommandCreate("right+jump+up+jump", "front-flip", function(){
	if (onGround) return;
	flip();
});

attackCommandCreate("jump+up+jump", "front-flip", function(){
	if (onGround) return;
	flip();
});

attackCommandCreate("up+jump", "front-flip", function(){
	if (onGround) return;
	flip();
});

#endregion


#endregion

analogPressed = false;

attack = function() {
	if (busy || isAttacking) return;
	
	if (Keymap.player.attack) {
		
		var atk = instance_create_depth(floor(x), floor(y), depth, PlayerAttack);
		atk.sprite_index = sPlayer_Attack1;
		atk.image_xscale = image_xscale;
		atk.initialDirection = image_xscale;
		
		atk.damage = damage;
		
		var hdir = image_xscale;
		var vdir = Keymap.player.jumpHold && onGround;
		
		if (vdir && hsp == 0) hdir = 0; 
		
		atk.dir = vec2(
			hdir,
			vdir
		);
		
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
			if (command.run()) print(command.name);
			attackCommandInput = "";
		}
		
		attackCommandTimer = 0;
	}
	
	// Reset combo thingy	
	attackCommandTimer += GameSpeed;
	if (attackCommandTimer > PLAYER_COMMAND_INPUT_TIMER) attackCommandInput = "";
	
	
	// handle weapons
	var hand = inventory.getCurrentSlot().itemID;
	
	//if (Keymap.player.attack && ITEM.getType(hand) == ITEM_TYPE.Weapon) {
	//}
}



// Inventory
#macro ITEM_STACK 10

inventory = {};

inventory.content = [];
inventory.slots = [];

inventory.equipment = {
	hand: -1,
	armor: -1,
};

inventory.getItemSlot = function(itemID, quantity) {
	var item = {}
	
	item.itemID = itemID;
	item.quantity = quantity;
	
	return item;
}

inventory.getCurrentSlot = function() {
	return inventory.slots[inventory.slotIndex];
}

inventory.setSlot = function(slotID, itemID) {
	inventory.slots[slotID].itemID = itemID;
}

inventory.hasItem = function(itemID) {
	for (var i = 0; i < array_length(inventory.content); i++) {
		if (inventory.content[i].itemID == itemID) {
			return true;
		}
	}
	return false;
};

inventory.add = function(itemID, quantity = 1) {
	var found = false;
	for (var i = 0; i < array_length(inventory.content); i++) {
		var c = inventory.content[i];
		
		// found existing item on inventory
		if (c.itemID == itemID) {
			
			if (c.quantity < ITEM_STACK - quantity) {
				c.quantity += quantity;
			
			} else {
				array_push(inventory.content, inventory.getItemSlot(itemID, quantity));
				
			}
			
			found = true;
		}
	}
	
	if (!found) array_push(inventory.content, inventory.getItemSlot(itemID, quantity));
};

inventory.removeItem = function() {
	
};


// HARDCODE ALERT
repeat(10) {
	array_push( inventory.content, inventory.getItemSlot(-1, 0) );
}

repeat(2) {
	array_push( inventory.slots, inventory.getItemSlot(-1, 0) );
}


inventory.slotIndex = 0;

drawInventorySlotsGUI = function() {
	var height = sprite_get_height(sItemSlot);
	var scale = Style.guiScale;
	var padding = 1.25 * scale;
	var alpha = 0.5;
	
	for (var i=0; i<array_length(inventory.slots); i++) {
		if (i == inventory.slotIndex) {
			scale = Style.guiScale * 1.15;
			alpha = 1;
			
			// Draw item names
			var item = ITEM.get( inventory.slots[i].itemID );
			if (item) {
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle);
				draw_text_transformed(100, (HEIGHT - 64) - i * height * padding, item.name, 1, 1, 0);
			}
		} else {
			scale = Style.guiScale; 
			alpha = 0.5;
		}
		
		draw_sprite_ext(sItemSlot, 0, 64, (HEIGHT - 64) - i * height * padding, scale, scale, 0, c_white, alpha);
	}
	
	if (mouse_wheel_down() && inventory.slotIndex > 0) inventory.slotIndex --;
	if (mouse_wheel_up() && inventory.slotIndex < array_length(inventory.slots) - 1) inventory.slotIndex ++;
}




// Draw
angle = 0;

spriteStates = {
	idle: sPlayerOneEye_Idle,
	move: sPlayerOneEye_Move,
	attack: sPlayerOneEye_Attack,
}

blink = false;

draw = function() {
	if (!isVisible) return;
	
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
	
	// Draw player sprite
	if (hitCooldown == 0 || !blink) {
		draw_outline(1, angle, Style.outlineColor);
	}
	
	//if (jumpCount < jumpCountDefault) {
	//	draw_sprite_ext(sPlayer_DoubleJumpFireы, -1, x, y + sprite_height / 2, image_xscale, 1, sin(current_time * 0.001) * 0.5, c_white, 1);
	//}
	
	if (surface_exists(SurfaceHandler.surface)) surface_reset_target();
}

// Draw GUI
drawGUI = function() {
	if (Paused) return;
	
	var guiScale = Style.guiScale;
	var margin = 20 * guiScale;
	
	
	// SubItem display
	draw_sprite_ext(sItemDisplay, 0, margin, margin, guiScale, guiScale, 0, c_white, 1);
	
	if (subitem != undefined) {
		var si = SUBITEM.get(subitem);
		draw_sprite_ext(si.sprite, 0, margin, margin, guiScale, guiScale, 0, c_white, 1);
	}
	
	
	if (hpDisplay > hp.value) {
		hpDisplay = lerp(hpDisplay, hp.value, 0.25);
	}
	
	var maxHpDisplay = 100;
	var hpPart = (hpDisplay / hp.defaultValue);
	
	for (var i = 0; i < maxHpDisplay; i++) {
		var xoffset = (sprite_get_width(sItemDisplay) * guiScale) / 2 + margin;
		var width = (sprite_get_width(sHealthbar) * guiScale);
		
		var color = c_white;
		
		var sprite = sHealthbar;
		if (i == maxHpDisplay - 1) sprite = sHealthbar_end;
		
		if (i >= ceil(maxHpDisplay * hpPart)) color = c_dkgray;
		
		draw_sprite_ext(sprite, 0, xoffset + i * width, margin, guiScale, guiScale, 0, color, 1);
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
	
	draw_text_transformed(WIDTH / 2, HEIGHT / 2, TRANSLATION.get("gui_death_screen_message"), messageScale, messageScale, 0);
	
	draw_set_alpha(1);
	
}



