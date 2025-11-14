
if (sprite_index == -1) return;

image_speed = GameSpeed;

depth = layer_get_depth(layer_get_id("PlayerAttack"));

draw_self();

effect_run(self, "draw");
