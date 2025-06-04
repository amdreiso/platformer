
if (sprite == -1) return;

sprite_index = sprite;
image_angle = dir;



surface_set_target(SurfaceHandler.surface);

draw_sprite_ext(sprite, 0, x, y, 1, 1, image_angle, c_white, 1);

surface_reset_target();
