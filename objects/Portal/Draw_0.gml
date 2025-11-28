
sprite_index = sprite;


if (!surface_exists(surface)) {
	surface = surface_create(room_width, room_height);
}


if (surface_exists(surface)) surface_set_target(surface);

var angle = (current_time / 100) + sin(current_time * 0.001) * 20;

draw_sprite_ext(sprite, 1, x, y, 1, 1, angle, c_white, 1);
draw_sprite_ext(sprite, 0, x, y, 1, 1, 0, c_white, 1);

if (surface_exists(surface)) surface_reset_target();

draw_surface(surface, 0, 0);


if (place_meeting(x, y, Player)) {
	image_index = 0;
	draw_outline(1, 0, $ffffff50);
}



