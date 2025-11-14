function create_popup_particle(value){
	var p = instance_create_depth(x, y - 4, depth, Particle_Popup);
	p.value = string(round(value));
}