
//drawLight();

//var color = COLOR.Purple;

//shader_set(shd_shiny);

//// uniforms
//shader_set_uniform_f(
//    shader_get_uniform(shd_shiny, "u_time"),
//    current_time / 1000
//);

//shader_set_uniform_f(
//    shader_get_uniform(shd_shiny, "u_strength"),
//    0.5
//);

//shader_set_uniform_f(
//    shader_get_uniform(shd_shiny, "u_color"),
//    color.r, color.g, color.b
//);

////texture_set_stage(1, sprite_get_texture(sTex_Shiny_0, 0));

////vertex_submit(vb, pr_trianglestrip, tex);
////texture_set_stage(1, sprite_get_texture(sTex_Shiny_1, 0));

event_inherited();

//shader_reset();