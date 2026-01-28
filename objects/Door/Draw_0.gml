
event_inherited();

draw_self();

collision.x = x;
collision.y = y;

if (active) {
	x = positionActive.x;
	y = positionActive.y;
} else {
	x = positionInactive.x;
	y = positionInactive.y;	
}
