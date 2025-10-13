
x += hsp;
y += vsp;

var playerCollision = (place_meeting(x, y + 1, Player));

//if (active && playerCollision) {
//	vsp = -0.1;
//	Player.y = y - sprite_get_height(Player.sprite_index) / 2;
//	camera_shake(0.6);
//}

if (active && playerCollision) {
	
	// Current Destination
	var cd = destinations[destinationIndex];
	
	var xx = round(x);
	var yy = round(y);
	
	if (cd.x == xx && cd.y == yy) {
		destinationIndex ++;
	
	} else {
		move_towards_point(cd.x, cd.y, 0.25);
		
		
	}
	
}


if (playerCollision) {
	if (Keymap.player.interact) {
		active = true;
	}
}
