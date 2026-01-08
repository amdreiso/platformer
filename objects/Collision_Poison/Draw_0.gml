
gpu_set_blendmode(bm_add);

var width = sprite_width;
var height = sprite_height;

var color = c_green;
var transparent = c_black;

draw_set_alpha(0.3);

draw_rectangle_colour(
	x, y + height / 2, x + width, y + height,
	transparent, transparent, color, color, false
);


draw_set_alpha(1);

gpu_set_blendmode(bm_normal);


