
camera_shake(3);
create_explosion_particles(x, y - 10, sprite_width, 30, random_range(0.05, 0.15));

if (instance_number(Junkdigger_Hand) < 2) {
	var cs = (instance_create_depth(0, 0, depth, Cutscene_Junkeeper));
	cs.cutsceneIndex = cs.cutsceneNoHands;
}
