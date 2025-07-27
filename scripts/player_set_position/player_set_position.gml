function player_set_position(pos = vec2()){
	if (!instance_exists(Player)) return;
	Player.x = pos.x;
	Player.y = pos.y;
}