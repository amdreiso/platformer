function draw_outline(offset, angle = 0, color = c_gray, alpha = 1){

	var a = offset;
	
	gpu_set_fog(true, color, 0, 1);
	
	draw_sprite_ext(sprite_index, image_index, x-a, y, image_xscale, image_yscale, angle, color, alpha);
	draw_sprite_ext(sprite_index, image_index, x, y-a, image_xscale, image_yscale, angle, color, alpha);
	draw_sprite_ext(sprite_index, image_index, x+a, y, image_xscale, image_yscale, angle, color, alpha);
	draw_sprite_ext(sprite_index, image_index, x, y+a, image_xscale, image_yscale, angle, color, alpha);
	
	gpu_set_fog(false, c_white, 0, 1);

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, image_blend, alpha);

}