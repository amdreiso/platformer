
if (sprite == -1) return;

if (randomSprite) {
	image_speed = 0;
	image_index = irandom(sprite_get_number(sprite));
	
	randomSpriteCallback.Run(self);
	randomSprite = false;
}

image_blend = color;

image_xscale = xscale * scale;
image_yscale = yscale * scale;

sprite_index = sprite;
image_alpha = alpha;

if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, image_blend, image_alpha);

if (surface_exists(SurfaceHandler.surface)) surface_reset_target();

