
alarm_set(0, irandom_range(2, 120));

repeat (irandom_range(1, 3)) {
	var xx = x + irandom_range(-range.x, range.x);
	var yy = y + irandom_range(-range.y, range.y);
	
	instance_create_depth(xx, yy, depth, Particle_WaterDrop);
}
