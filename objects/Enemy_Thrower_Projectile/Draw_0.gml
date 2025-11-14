
image_xscale = scale;
image_yscale = scale;

image_angle = angle;

if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);

draw_self();

if (surface_exists(SurfaceHandler.surface)) surface_reset_target();




