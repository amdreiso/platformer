

// Player
busy = false;
children = [];
lightLevel = 20;
isSolid = true;
raycastCount = 180;
viewDistanceDefault = 50;
viewDistance = 50;

emitter = audio_emitter_create();

soul = SOUL_TYPE.Castoff;


// Movement
allowMovement = true;
defaultSpd = 1.3;
spd = defaultSpd;
hsp = 0;
vsp = 0;
force = vec2();
jumpForce = 1.85;
jumpCountDefault = 1;
jumpCount = jumpCountDefault;
onGround = false;
onSlope = false;
isMoving = false;
isFlipping = false;
noclip = false;

lastPlaceStanding = -1;


flip = function() {
	isFlipping = true;
	angle = image_xscale * 5;
}

handleBackflip = function() {
	if (!isFlipping) return;
	
	var time = 360 / 45;
	angle = angle + (time) * -image_xscale;
	
	if (abs(angle) >= 355) { angle = 0; isFlipping = false; }
}

movement = function() {
	if (busy) return;
	
	isMoving = (hsp != 0 || vsp != 0);
	
	spd = defaultSpd;
	onGround = (
		place_meeting(x, y + 1, Collision) ||
		place_meeting(x, y + 1, Collision_Slope) || 
		place_meeting(x, y + 1, Collision_JumpThrough) || 
		place_meeting(x, y + 1, Collision_Rayblock)
	);
	
	if (onGround) {
		onSlope = false;
		jumpCount = jumpCountDefault;
		isFlipping = false;
		
		lastPlaceStanding = vec2(x, y);
	}
	
	if (place_meeting(x, y + 1, Collision_Slope)) {
		onSlope = true;
	}
	
	x += hsp + force.x;
	y += vsp + force.y;
	
	// Gravity
	vsp = (vsp + Gravity) * GameSpeed;
	
	apply_force();
	
	
	// max falling speed
	vsp = clamp(vsp, -MAX_FALLING_SPEED, MAX_FALLING_SPEED);
	
	// if on cutscene disable movement
	if (OnCutscene) return;
	
	var map = Keymap.player;
	var left = map.left;
	var right = map.right;
	var jump = map.jump;
	
	var dir = point_direction(0, 0, right - left, 0);
	var len = (right - left != 0);
	
	if (!isHit) {
		hsp = lengthdir_x(spd * len, dir) * GameSpeed;
	}
	
	
	// Jump
	if (map.jump && jumpCount > 0) {
		vsp = 0;
		vsp -= jumpForce;
		
		if (!onGround) flip();
		
		jumpCount --;
	}
	
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
}

dash = function() {
	if (keyboard_check_pressed(vk_shift)) {
		force.x = sign(hsp) * 2;
	}
}


// Collisions
collisions = {
	solid: [Collision, Collision_JumpThrough, Collision_Rayblock, Collision_Slope],
};


applyCollisions = function() {
	if (noclip) return;
	
	var jumpThrough = instance_place(x, y + max(1, vsp), Collision_JumpThrough);
	if (jumpThrough && floor(bbox_bottom) <= jumpThrough.bbox_top) {
		if (vsp > 0) {
			while (!place_meeting(x, y + sign(vsp), Collision_JumpThrough)) {
				y += sign(vsp);
			}
			vsp = 0;
		}
	}
	
	collision_set(Collision);
	collision_set(Collision_Slope);
	collision_set(Collision_Rayblock);
	
	if (place_meeting(x, y, Trigger)) {
		instance_destroy(instance_nearest(x, y, Trigger));
	}
	
	if (place_meeting(x, y, ProjectileEnemy)) {
		var proj = instance_nearest(x, y, ProjectileEnemy);
		hit(proj.damage);
		instance_destroy(proj);
	}
}


// Attack
attack = function() {
	if (busy || instance_exists(PlayerAttack)) return;
	
	if (Keymap.player.specialAttack) {
		var atk = instance_create_depth(floor(x), floor(y), depth, PlayerAttack);
		atk.sprite_index = sAttack1;
		atk.image_xscale = image_xscale;
		atk.image_angle = image_angle;
		
		var hdir = image_xscale;
		var vdir = Keymap.player.jumpHold && onGround;
		
		if (vdir && hsp == 0) hdir = 0; 
		
		atk.dir = vec2(
			hdir,
			vdir
		);
	}
	
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

inventory.add = function(itemID, amount = 1) {
	var found = false;
	for (var i = 0; i < array_length(inventory.content); i++) {
		var c = inventory.content[i];
		
		if (c.itemID == itemID) {
			if (c.amount < ITEM_STACK - amount) {
				c.amount += amount;
			} else {
				array_push(inventory.content, inventory.getItemSlot(itemID, amount));
			}
			
			found = true;
		}
	}
	
	if (!found) array_push(inventory.content, inventory.getItemSlot(itemID, amount));
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


// Health
defaultHp = 20;
hp = defaultHp;
isHit = false;
hitCooldown = 0;

handleHealth = function() {
	hitCooldown = max(0, hitCooldown - GameSpeed);
	if (hitCooldown == 0) isHit = false;
}

hit = function(damage, xscale=1) {
	if (isHit) return;
	
	hp -= damage;
	isHit = true;
	hitCooldown = 30;
	
	vsp = 0;
	force.y -= jumpForce;
	hsp += -2.5 * xscale;
	
	flip();
	
	camera_shake(3, 1.50);
	
	var hitSound = choose(snd_hit1, snd_hit2);
	audio_play_sound(hitSound, 0, false, 0.5, 0, random_range(0.80, 1.00));
}


// Draw
angle = 0;

spriteStates = {
	idle: sPlayerOneEye_Idle,
	move: sPlayerOneEye_Move,
}

draw = function() {
	var sprite = spriteStates.idle;
	
	if (hsp != 0) {
		sprite = spriteStates.move;
		image_xscale = sign(hsp);
	}
	
	if (busy) {
		sprite = spriteStates.idle;
	}
	
	sprite_index = sprite;
	
	if (onGround || onSlope) {
		angle = angle_lerp(angle, 0, 0.25);
	}
	
	surface_set_target(SurfaceHandler.surface);
	
	// Draw player with an outline
	draw_outline(1, angle, Style.outlineColor);
	
	surface_reset_target();
}


// Draw GUI
drawGUI = function() {
	var guiScale = Style.guiScale;
	var margin = 20 * guiScale;
	
	draw_sprite_ext(sItemDisplay, 0, margin, margin, guiScale, guiScale, 0, c_white, 1);
	
	for (var i = 0; i < defaultHp; i++) {
		var xoffset = (sprite_get_width(sItemDisplay) * guiScale) / 2 + margin;
		var width = (sprite_get_width(sHealthbar) * guiScale);
		
		var color = c_white;
		
		var sprite = sHealthbar;
		if (i == defaultHp-1) sprite = sHealthbar_end;
		
		if (i > hp) color = c_dkgray;
		
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
	
	rect(WIDTH/2, HEIGHT/2, labelBackgroundX, 80, c_black, false, 0.35);
	
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
	  var dy = HEIGHT / 2 - string_height(tc.char) * tc.scale / 2;
    
	  dx += random_range(-tc.shake, tc.shake);
	  dy += random_range(-tc.shake, tc.shake);
		
		draw_set_font(fnt_main);
		
	  draw_text_transformed_color(dx, dy, tc.char, tc.scale, tc.scale, tc.angle, tc.color, tc.color, tc.color, tc.color, secretAlpha);
	  xoffset += string_width(tc.char);
	}
		
	secretTime += GameSpeed;
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


