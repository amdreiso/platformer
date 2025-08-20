
event_inherited();

name = "Junkeeper";

active = false;

hsp = 0;
vsp = 0;

head = instance_create_depth(x, y, depth, Junkdigger_Head);
headOffset = vec2(0, -50);

body = instance_create_depth(x, y, depth, Junkdigger_Body);
bodyOffset = vec2(0, -50);


var yy = y + 40;
leftHand = instance_create_layer(x - 100, yy, "Boss_Hand_Front", Junkdigger_Hand);

rightHand = instance_create_layer(x + 100, yy, "Boss_Hand_Front", Junkdigger_Hand);
rightHand.image_xscale = -1;


face = sBoss_Junkdigger_Cringe_FE;


door = instance_create_layer(256, 496, "Instances", DoorSideways);
door.openable = false;




