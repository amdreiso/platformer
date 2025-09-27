
if (sprite == -1) return;

if (getRandomSprite) {
	image_speed = 0;
	image_index = irandom(sprite_get_number(sprite));
	
	getRandomSprite = false;
}

image_blend = color;

image_xscale = xscale * scale;
image_yscale = yscale * scale;

sprite_index = sprite;
image_alpha = alpha;

if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);
draw_self();
if (surface_exists(SurfaceHandler.surface)) surface_reset_target();

