
event_inherited();

name = "Junkdigger";

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



// Create tentacles
//repeat (10) {
	
//	var rope = instance_create_layer(x, y, "Boss_Tentacles", Rope);
	
//	with (rope) {
//		sprite = -1;
		
//		var type = irandom(3) + 1;
//		var size;
		
//		// Colors
//		colors = [ make_color_rgb(236, 39, 63) ];
//		size = 1;
//		segments = 19;
		
//		width = 2.5 * size;
//		length = 4 * size;
		
//		descending = -0.1 * size;
		
//		createSegments();
//	}
	
//	var rand = 25;
//	rope.xoffset = irandom_range(-rand, rand);
//	rope.yoffset = irandom_range(-rand, rand) / 2;
	
//	append(rope);
	
//}

