
if (!surface_exists(surface)) return;

draw_surface(surface, 0, 0);

surface_set_target(surface);

draw_clear_alpha(c_white, 0);

surface_reset_target();
