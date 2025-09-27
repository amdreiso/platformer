
isSolid = true;
rope = [];

width = 1.5;
length = 3;
colors = [c_olive, c_lime];

descending = 0;

segments = 12;

apply = false;
sprite = sChain;

ropeAppend = function(index, obj) {
	array_push(rope[index].children, obj);
}

createSegments = function() {
	if (sprite != -1) {
		length = sprite_get_height(sprite);
	}
	
  rope = [];
	for (var i = 0; i < segments; i++) {
		var color = colors[irandom(array_length(colors)-1)];
		var p = rope_create_point(x, y + i * length, random_array_argument(width) + (i * descending), color);
	  if (i == 0) p.pinned = true;
	  array_push(rope, p);
	}
	
	apply = true;
}

createSegments();

draw = function() {
	if (!apply) return;

	draw_set_color(c_white);
	for (var i = 0; i < segments - 1; i++) {
	
		if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);
		
		if (sprite == -1) {
			draw_set_color(rope[i].color);
			draw_line_width(rope[i].x, rope[i].y, rope[i+1].x, rope[i+1].y, rope[i].width);
			draw_set_color(c_white);
		} else {
			
			var dir = point_direction(rope[i].x, rope[i].y, rope[i + 1].x, rope[i + 1].y) + 90;
			draw_sprite_ext(sprite, 0, rope[i].x, rope[i].y, 1, 1, dir, c_white, 1);
			
			length = sprite_get_height(sprite);
		}
	
		if (surface_exists(SurfaceHandler.surface)) surface_reset_target();
	}
}
