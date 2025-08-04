
draw();


gpu_set_blendmode(bm_add);
draw_set_alpha(lightAlpha);

if (is_array(lightLevel)) {
	draw_circle_color(x, y, lightLevel[intensityIndex], lightColor, lightColor, false);
	
} else {
	draw_circle_color(x, y, lightLevel, lightColor, lightColor, false);
}


draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
