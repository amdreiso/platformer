

var breakingPointFrame = 0;
var xscale = sprite_get_width(sprite) / sprite_get_width(sBreakingPoint);
var yscale = sprite_get_height(sprite) / sprite_get_height(sBreakingPoint);

if (hp == 1) {
	breakingPointFrame = 1;
}

sprite_index = sprite;
draw_self();

if (hp != 3) {
	for (var i = 0; i < xscale; i++) {
		for (var j = 0; j < yscale; j++) {
			var xx = x + i * sprite_get_width(sBreakingPoint);
			var yy = y + j * sprite_get_height(sBreakingPoint);
			
			draw_sprite_ext(sBreakingPoint, breakingPointFrame, xx, yy, 1, 1, 0, c_black, 0.5);
		}
	}
}

var w, h;
w = sprite_get_width(sprite);
h = sprite_get_height(sprite);

if (!surface_exists(surface)) {
	surface = surface_create(w, h);
}

surface_set_target(surface);

draw_sprite(sprite, 0, 0, 0);

surface_reset_target();


