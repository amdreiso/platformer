function draw_outline(scale, angle, color){
	
	gpu_set_fog(true, color, 0, 1);
	
	var a = scale;
	
	draw_sprite_ext(sprite_index, image_index, x-a, y, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x, y-a, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x+a, y, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x, y+a, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x-a, y-a, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x+a, y+a, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x-a, y+a, image_xscale, image_yscale, angle, color, 1);
	draw_sprite_ext(sprite_index, image_index, x+a, y-a, image_xscale, image_yscale, angle, color, 1);
	
	gpu_set_fog(false, c_white, 0, 1);
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, c_white, 1);
	
}