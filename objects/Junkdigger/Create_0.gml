
event_inherited();

#macro JUNKKEEPER_HAND_POSITION 533

children = new Children();

hp = 100;

hit = function(multiplier = 1){
	_m = multiplier;
	
	player_attack_check(function(atk){
		Junkdigger.hp -= atk.damage * _m;
		
	});
}

name = "Junk Reaper";

active = false;
dead = false;

head = instance_create_depth(x, y, depth, Junkdigger_Head);
headOffset = new Vec2(0, -50);

body = instance_create_depth(x, y, depth, Junkdigger_Body);
bodyOffset = new Vec2(0, -50);

children.Append(head, body);

dynamiteCooldown = 60;

var yy = y + 200;
leftHand = instance_create_layer(x - 100, yy, "Boss_Hand_Back", Junkdigger_Hand);

rightHand = instance_create_layer(x + 100, yy, "Boss_Hand_Back", Junkdigger_Hand);
rightHand.image_xscale = -1;


door = instance_create_layer(6 * 16, 31 * 16, "Instances", DoorSideways);
door.openable = false;

nohands = false;

// Set hp
defaultHp = leftHand.defaultHp + rightHand.defaultHp;

setHp = function() {
	
}

setHp();

