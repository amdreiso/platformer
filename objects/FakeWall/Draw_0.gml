

var breakingPointFrame = 0;
var xscale = sprite_get_width(sprite) / sprite_get_width(sBreakingPoint);
var yscale = sprite_get_height(sprite) / sprite_get_height(sBreakingPoint);

if (hp == 1) {
	breakingPointFrame = 1;
}

sprite_index = sprite;
draw_self();

if (hp != 3) draw_sprite_ext(sBreakingPoint, breakingPointFrame, x, y, xscale, yscale, 0, c_black, 0.5);


