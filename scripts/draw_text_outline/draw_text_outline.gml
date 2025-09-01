function draw_text_outline(x, y, str, xscale, yscale, angle, alpha, font, back = c_black, fore = c_white){
	
	
	draw_set_font(font);
	
	draw_text_transformed_color(x-xscale, y, str,				 xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x+xscale, y, str,				 xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x-xscale, y-yscale, str, xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x+xscale, y+yscale, str, xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x+xscale, y-yscale, str, xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x-xscale, y+yscale, str, xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x,				y-yscale, str, xscale, yscale, angle, back, back, back, back, alpha);
	draw_text_transformed_color(x,				y+yscale, str, xscale, yscale, angle, back, back, back, back, alpha);
	
	draw_text_transformed_color(x, y, str, xscale, yscale, angle, fore, fore, fore, fore, alpha);
	
	draw_set_font(DEFAULT_FONT);
	
}