
depth = 9999;

var offset = sin(current_time * 0.001) * 5;
var offsetx = ((1 / (GameSpeed / offset)) - 1);
var alpha = ((1 / (GameSpeed)) - 1);
var defaultalpha = 0.15;

if (abs(GameSpeed) > 0.95) return; 

gpu_set_blendmode(bm_add);

draw_surface_ext(application_surface, -offsetx, 0, 1, 1, 0, c_aqua, defaultalpha * alpha);
draw_surface_ext(application_surface, offsetx, 0, 1, 1, 0, c_orange, defaultalpha * alpha);

gpu_set_blendmode(bm_normal);

