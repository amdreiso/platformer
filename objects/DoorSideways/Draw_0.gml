
draw_self();

if (!open && floor(image_index) == 0) {
	var auracolor = c_white;
	var auraalpha = (sin(current_time * 0.001) * 0.5) + 0.75;
	
	switch (soulType) {
		case SOUL_TYPE.Castoff:
			auraalpha = 0;
			break;
			
		case SOUL_TYPE.Royal:
			auracolor = c_aqua;
			break;
	}
	
	draw_sprite_ext(sDoorSideway1_aura, 0, x, y, image_xscale * dir, image_yscale, 0, auracolor, auraalpha);
}
