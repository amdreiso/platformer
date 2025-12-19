
if (sprite == -1) return;

sprite_index = sprite;
image_angle = direction;
image_xscale = scale;
image_yscale = scale;

if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);

draw_sprite_ext(sprite, 0, x, y, scale, scale, image_angle, c_white, 1);

if (surface_exists(SurfaceHandler.surface)) surface_reset_target();


