
image_xscale = scale;
image_yscale = scale;

image_angle = angle;

surface_set_target(SurfaceHandler.surface);

draw_self();

surface_reset_target();
