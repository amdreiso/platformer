
event_inherited();

#macro JUNKKEEPER_HAND_POSITION 533

name = "JUNK-KEEPER";

active = false;
dead = false;

head = instance_create_depth(x, y, depth, Junkdigger_Head);
headOffset = vec2(0, -50);

body = instance_create_depth(x, y, depth, Junkdigger_Body);
bodyOffset = vec2(0, -50);


var yy = y + 200;
leftHand = instance_create_layer(x - 100, yy, "Boss_Hand_Back", Junkdigger_Hand);

rightHand = instance_create_layer(x + 100, yy, "Boss_Hand_Back", Junkdigger_Hand);
rightHand.image_xscale = -1;


door = instance_create_layer(6 * 16, 31 * 16, "Instances", DoorSideways);
door.openable = false;


// Set hp
defaultHp = leftHand.defaultHp + rightHand.defaultHp;

setHp = function() {
	var hpl = 0;
	var hpr = 0;
	
	if (instance_exists(leftHand)) hpl = leftHand.hp;
	if (instance_exists(rightHand)) hpr = rightHand.hp;
	
	hp = hpl + hpr;
}

setHp();






