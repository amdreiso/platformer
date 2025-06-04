
// Open
if (place_meeting(x, y, Player) && !beginCollision && Player.soul > SOUL_TYPE.Castoff && ranLastFrame) {
	beginCollision = true;
	active = false;
	animation = true;
}

// Close
if (!place_meeting(x, y, Player) && beginCollision && ranLastFrame) {
	beginCollision = false;
	active = true;
	animation = true;
}
