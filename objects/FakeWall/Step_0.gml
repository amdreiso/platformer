
if (place_meeting(x, y, PlayerAttack)) {
	if (!PlayerAttack.used) {
		hit();
		PlayerAttack.used = true;
	}
}
