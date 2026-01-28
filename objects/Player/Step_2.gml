
hspf = hsp;
vspf = vsp - Gravity;

// Apply all collisions
applyCollisions();

var lastx = x;
var lasty = y;

if (place_meeting(x, y, Player) && x == lastx && y == lasty) {
	print("Stuck");
}

if (!busy) {
	x += hsp * GameSpeed;
	y += vsp * GameSpeed;
}
