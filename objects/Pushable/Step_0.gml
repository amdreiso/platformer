
children.ForEach(function(obj){
	obj.x = x - 8;
	obj.y = y - 8;
});

//if (place_meeting(x, y-1, Player)) {
//	Player.x += hsp;
//	Player.y += vsp;
//}

x += hsp;
y += vsp;

var weight = 5;
var side = object_side(Player);

collision_set(Collision);

if (place_meeting(x + side.x, y, Player)) {
	hsp += Player.hspf / weight;
	//vsp += Player.vspf / weight;
	
} else {
	hsp = 0;
	vsp = 0;
}

