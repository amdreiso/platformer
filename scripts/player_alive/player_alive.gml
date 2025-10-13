function player_alive(){
	var alive;
	
	if (!instance_exists(Player)) return;
	
	alive = (!Player.isDead);
	
	return alive;
}