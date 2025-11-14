function player_set_position(pos = new Vec2()){
	if (!instance_exists(Player)) return;
	Player.x = pos.x;
	Player.y = pos.y;
}