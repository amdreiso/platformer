
if (sprite == -1) return;

if (getRandomSprite) {
	image_speed = 0;
	image_index = irandom(sprite_get_number(sprite));
	
	getRandomSprite = false;
}

image_xscale = xscale * scale;
image_yscale = yscale * scale;

sprite_index = sprite;
image_alpha = alpha;

surface_set_target(SurfaceHandler.surface);
draw_self();
surface_reset_target();

