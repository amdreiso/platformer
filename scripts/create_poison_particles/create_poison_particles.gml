function create_poison_particles(pos){
	
	var p = instance_create_depth(pos.x, pos.y, depth - 100, Particle_Poison);
	
	var angleshift = 30;
	
	if (instance_exists(p)) {
		
		p.gravityApply = false;
		p.color = choose(c_white, c_ltgray);
		p.angle = irandom_range(-angleshift, angleshift);
		p.scale = random_range(0.325, 1.25);
		
	}
	
}