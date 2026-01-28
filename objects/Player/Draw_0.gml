

if (Level.isCutscene) return;

//shader_set(shd_normal);

//var lightStrength = 0.0;
//var r = 1, g = 1, b = 1;
//var radius = 128;

//if (instance_exists(Light)) {
//    var light = instance_nearest(x, y, Light);
//    var dist = point_distance(x, y, light.x, light.y);

//    radius = light.radius;
//    lightStrength = clamp(1.0 - dist / radius, 0.0, 5.0);
//    lightStrength *= light.intensity;

//    r = color_get_red(light.color) / 255;
//    g = color_get_green(light.color) / 255;
//    b = color_get_blue(light.color) / 255;

//    shader_set_uniform_f(
//        shader_get_uniform(shd_normal, "u_light_pos"),
//        light.x, light.y
//    );
//}

//shader_set_uniform_f(shader_get_uniform(shd_normal, "u_light_radius"), radius);
//shader_set_uniform_f(shader_get_uniform(shd_normal, "u_light_color"),
//    r * lightStrength,
//    g * lightStrength,
//    b * lightStrength
//);
//shader_set_uniform_f(shader_get_uniform(shd_normal, "u_ambient"), 1.0);

//texture_set_stage(1, sprite_get_texture(sNormal_Player, 0));

draw();

//shader_reset();

if (Debug.debug) {
	if (!is_undefined(lastPlaceStanding)) {
		draw_circle(lastPlaceStanding.x, lastPlaceStanding.y, 4, true);
	}
}

draw_debug();


// Upgrades
upgrade.draw(self);


// Effects
effect_run(self, "draw");

