
if (Style.palette == -1) return;
shader_set(shd_color);

var sprite = Style.palette;
var palette = sprite_get_texture(sprite, 0);
texture_set_stage(shader_get_sampler_index(shd_color, "u_palette"), palette);
shader_set_uniform_f(shader_get_uniform(shd_color, "u_colors"), sprite_get_width(sprite));
shader_set_uniform_f(shader_get_uniform(shd_color, "u_intensity"), 2);

draw_surface(application_surface, 0, 0);

shader_reset();
