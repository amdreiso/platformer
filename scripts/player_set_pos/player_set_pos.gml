function player_set_pos(pos, camera=true){
	if (!instance_exists(Player)) return;
	Player.x = pos.x;
	Player.y = pos.y;
	
	if (camera) {
		if (!instance_exists(Camera)) return;
		Camera.x = pos.x;
		Camera.y = pos.y;
	}
}