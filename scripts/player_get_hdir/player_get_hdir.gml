function player_get_hdir(){
	if (!instance_exists(Player)) return;
	
	var val = 1;
	
	if (Player.x < x) {
		val = -1;
	} else {
		val = 1;
	}
	
	return val;
}