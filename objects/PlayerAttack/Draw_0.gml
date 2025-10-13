
if (sprite_index == -1) return;

depth = layer_get_depth(layer_get_id("PlayerAttack"));

draw_self();

effect_run(self, "draw");
