
//depth = layer_get_depth(layer_get_id("Lighting"));


surface_depth_disable(true);
if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);

if (sprite != -1) {
	sprite_index = sprite;
	draw_self();
}


if (surface_exists(SurfaceHandler.surface)) surface_reset_target();

depth = -99999;

gpu_set_blendmode(blendmode);
draw_set_alpha(lightAlpha * (intensity / 2));

draw_circle_color(x, y, radius, image_blend, c_black, false);
//draw_raycast(PlayerCollision, x, y, raycastCount, radius, 2, color, c_black);

draw_set_alpha(1);

gpu_set_blendmode(bm_normal);
