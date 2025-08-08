
//depth = layer_get_depth(layer_get_id("Lighting"));


surface_depth_disable(true);
surface_set_target(SurfaceHandler.surface);

if (sprite != -1) {
	sprite_index = sprite;
	draw_self();
}


surface_reset_target();

depth = -99999;

gpu_set_blendmode(blendmode);
draw_set_alpha(lightAlpha);

if (is_array(intensity)) {
	draw_circle_color(x, y, intensity[intensityIndex], lightColor, c_black, false);
	
} else if (!is_array(intensity)) {
	draw_circle_color(x, y, intensity, lightColor, c_black, false);
}


draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
