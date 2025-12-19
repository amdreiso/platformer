
if (sprite_index == -1) return;

image_speed = GameSpeed;
image_angle = angle;

if (Sleep) image_speed = 0;

depth = layer_get_depth(layer_get_id("PlayerAttack"));

var s = SurfaceHandler.surface;
var e = surface_exists(s);
if (e) surface_set_target(s);

draw_self();

if (e) surface_reset_target();

effect_run(self, "draw");
