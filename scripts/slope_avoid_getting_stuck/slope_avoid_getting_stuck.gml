function slope_avoid_getting_stuck(){
	static freeSlopeTimer = 0;
	if (onSlope) {
		
		// check if is walking
		if (map.left || map.right) {
			freeSlopeTimer += GameSpeed;
			
			if (hsp == 0 && freeSlopeTimer > 1) {
				y -= 1;
				freeSlopeTimer = 0;
			}
		}
	}
}