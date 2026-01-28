
with (Player) {

	if (Debug.debug) {

		var level = LEVEL.Get(room);
		var len = array_length(level.components.transitions);
		
		for (var i = 0; i < len; i++) {
			t = level.components.transitions[i];
			var width = 10;
			var scale = 1;
			var color = c_black;
	
			switch (t.side) {
				case "left":
					button(0, t.y, width, t.y + ROOM_TILE_HEIGHT, "", true, c_white, c_white, 0.25, function(){
						draw_set_halign(fa_left);
						draw_text(mouse_x, mouse_y, room_get_name(t.roomID));
					
						draw_set_halign(fa_center);
					
						if (mouse_check_button_pressed(mb_left)) {
							room_transition(t.roomID, "left");
						}
					});
					break;
			
				case "right":
					button(room_width - width, t.y, room_width, t.y + ROOM_TILE_HEIGHT, "", true, c_white, c_white, 0.25, function(){
						draw_set_halign(fa_right);
						draw_text(mouse_x, mouse_y, room_get_name(t.roomID));
					
						draw_set_halign(fa_center);
					
						if (mouse_check_button_pressed(mb_left)) {
							room_transition(t.roomID, "right");
						}
					});
					break;
			
				case "up":
					button(t.x, 0, t.x + ROOM_TILE_WIDTH, width, "", true, c_white, c_white, 0.25, function(){
						draw_set_halign(fa_left);
						draw_text(mouse_x, mouse_y, room_get_name(t.roomID));
					
						draw_set_halign(fa_center);
					
						if (mouse_check_button_pressed(mb_left)) {
							room_transition(t.roomID, "up");
						}
					});
					break;
			
				case "down":
					button(t.x, room_height - width, t.x + ROOM_TILE_WIDTH, room_height, "", true, c_white, c_white, 0.25, function(){
						draw_set_halign(fa_left);
						draw_set_valign(fa_bottom);
						draw_text(mouse_x, mouse_y, room_get_name(t.roomID));
					
						draw_set_halign(fa_center);
						draw_set_valign(fa_middle);
					
						if (mouse_check_button_pressed(mb_left)) {
							room_transition(t.roomID, "up");
						}
					});
					break;
			
			}
		}
	
	
		with (all) {
			if (Debug.debug) {
				draw_rectangle(bbox_left, bbox_top, bbox_right-1, bbox_bottom-1, true);
	
				show_object_status();
			}
		}
	
	}

}


if (!surface_exists(surface)) {
	surface = surface_create(room_width, room_height);
	return;
}

draw_surface(surface, 0, 0);

surface_set_target(surface);

draw_clear_alpha(c_black, 0);
//surface_depth_disable(true);
//depth = 200;


// Draw darknesss uhhh
draw_set_alpha(darkness);
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);


// Draw Light
gpu_set_blendmode(bm_subtract);


with (Light) {
	if (distance_to_object(Player) < Camera.size.width) {
		draw_raycast(PlayerCollision, x, y, raycastCount, radius, lightWidth);
	}
	
}


gpu_set_blendmode(bm_normal);

surface_reset_target();






