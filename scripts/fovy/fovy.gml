

enum BUTTON_ORIGIN {
	Left, 
	MiddleCenter,
}


function fovy(){
	show_debug_message("Loaded fovy!");
}

function on_last_frame(fn) {
	if (round(image_index) == sprite_get_number(sprite_index)) {
		fn();
	}
}

function apply_force() {
  var decel = FORCE_DECELERATION * GameSpeed;

  if (abs(force.x) <= decel) {
    force.x = 0;
  } else {
    force.x -= decel * sign(force.x);
  }

  if (abs(force.y) <= decel) {
    force.y = 0;
  } else {
    force.y -= decel * sign(force.y);
  }
}

function collision_set(obj) {
	if (!instance_exists(obj)) return;
	
	if (instance_nearest(x, y, obj).image_yscale == -1) {
		return false;
	}
	
	var subPixel = 1;
	
	if (place_meeting(x + hsp + force.x, y, obj)) {
		
		// Slope up
		if (!place_meeting(x + hsp, y - abs(hsp) - 1, obj)) {
			
			while (place_meeting(x + hsp, y, obj)) {
				y -= subPixel;
			}
			
		} else {
 		
			while (!place_meeting(x + sign(hsp + force.x), y, obj)) {
				x = x + sign(hsp + force.x);
			}
		
			hsp = 0;
			force.x = 0;
			
		}
	}
	
	if (place_meeting(x, y + vsp + force.y, obj)) {
		while (!place_meeting(x, y + sign(vsp + force.y), obj)) {
			y = y + sign(vsp + force.y);
		}
		
		vsp = 0;
		force.y = 0;
	}
}

function vec2(x=0, y=0) {
	return {
		x: x,
		y: y,
	}
}

function randvec2(x=0, y=0, range=0) {
	return {
		x: x + random_range(-range, range),
		y: y + random_range(-range, range),
	}
}

function irandvec2(x=0, y=0, range=0) {
	return {
		x: x + irandom_range(-range, range),
		y: y + irandom_range(-range, range),
	}
}

function dim(width=0, height=0) {
	return {
		width: width,
		height: height,
	}
}

function sound3D(emitter, x, y, snd, loop, gain, pitch, offset = 0){
	if (emitter == -1) {
		return audio_play_sound_at(snd, x, y, 0, Sound.distance, Sound.dropoff, Sound.multiplier, 
			loop, -1, random_array_argument(gain), offset, random_array_argument(pitch));
	}
	
	return audio_play_sound_on(emitter, snd, loop, 0, random_array_argument(gain), offset, random_array_argument(pitch));
}

function rgb(r, g, b) constructor { self.r = r; self.g = g; self.b = b; }

function button(
	x, y, width, height, label = "",
	hasOutline = true, outlineColor = c_white, hoverColor = c_white, hoverAlpha = 0.25, hoverFunction = function(){},
	orientation = 0, cursor = true
) {
	var range;
	
	switch (orientation) {
		case BUTTON_ORIGIN.Left:
			
			range = (mouse_x > x && mouse_x < x + width && mouse_y > y && mouse_y < y + height);
			
			// Draw outline
			if (hasOutline) {
				draw_rectangle_color(
					x, y, 
					x + width, y + height, 
					outlineColor, outlineColor, outlineColor, outlineColor, true
				);
			}
			
			if (range) {
				draw_set_alpha(hoverAlpha);
				draw_rectangle_color(
					x, y, 
					x + width, y + height, 
					hoverColor, hoverColor, hoverColor, hoverColor, false
				);
				draw_set_alpha(1);
				
				if (cursor) {
					set_cursor(CURSOR.Pointer);
				}
				
				hoverFunction();
			}
			
			draw_text(x, y, label);
			
			break;
		
		case BUTTON_ORIGIN.MiddleCenter:
			
			range = (
				mouse_x > x - width / 2 && 
				mouse_x < x + width / 2 && 
				mouse_y > y - height / 2 && 
				mouse_y < y + height / 2
			);
			
			// Draw outline
			if (hasOutline) {
				draw_rectangle_color(
					x - width / 2, y - height / 2, 
					x + width / 2, y + height / 2, 
					outlineColor, outlineColor, outlineColor, outlineColor, true
				);
			}
			
			if (range) {
				draw_set_alpha(hoverAlpha);
				draw_rectangle_color(
					x - width / 2, y - height / 2, 
					x + width / 2, y + height / 2, 
					hoverColor, hoverColor, hoverColor, hoverColor, false
				);
				draw_set_alpha(1);
				
				hoverFunction();
			}
			
			draw_set_halign(fa_center);
			draw_text(x+width/2, y+height/2, label);
			draw_set_halign(fa_left);
			
			break;
	}
}

function button_gui(
	x, y, width, height, label = "", gamepadID = -1,
	hasOutline = true, outlineColor = c_white, hoverColor = c_white, hoverAlpha = 0.25, alpha = 1, hoverFunction = function(){},
	orientation = 0, cursor = true
) {
	var mx, my;
	mx = window_mouse_get_x();
	my = window_mouse_get_y();
	
	var range;
	
	switch (orientation) {
		case BUTTON_ORIGIN.Left:
			
			range = (mx > x && mx < x + width && my > y && my < y + height);
			
			// Draw outline
			if (hasOutline) {
				draw_set_alpha(alpha);
				
				draw_rectangle_color(
					x, y, 
					x + width, y + height, 
					outlineColor, outlineColor, outlineColor, outlineColor, true
				);
				
				draw_set_alpha(1);
			}
			
			if (range) {
				draw_set_alpha(hoverAlpha * alpha);
				draw_rectangle_color(
					x, y, 
					x + width, y + height, 
					hoverColor, hoverColor, hoverColor, hoverColor, false
				);
				draw_set_alpha(1);
				
				if (cursor) {
				}
				
				hoverFunction();
			}
			
			draw_set_valign(fa_middle);
			draw_text_color(x, y + height / 2, label, Style.textColor, Style.textColor, Style.textColor, Style.textColor, alpha);
			draw_set_valign(fa_top);
			
			break;
		
		case BUTTON_ORIGIN.MiddleCenter:
			
			range = (
				mx > x - width / 2 && 
				mx < x + width / 2 && 
				my > y - height / 2 && 
				my < y + height / 2
			);
			
			// Draw outline
			if (hasOutline) {
				draw_set_alpha(alpha);
				draw_rectangle_color(
					x - width / 2, y - height / 2, 
					x + width / 2, y + height / 2, 
					outlineColor, outlineColor, outlineColor, outlineColor, true
				);
				draw_set_alpha(1);
			}
			
			if (range) {
				draw_set_alpha(hoverAlpha * alpha);
				draw_rectangle_color(
					x - width / 2, y - height / 2, 
					x + width / 2, y + height / 2, 
					hoverColor, hoverColor, hoverColor, hoverColor, false
				);
				draw_set_alpha(1);
				
				if (cursor) {
				}
				
				hoverFunction();
			}
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			
			draw_set_alpha(alpha);
			draw_text(x, y, label);
			draw_set_alpha(1);
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			break;
	}
}

function draw_3d(step, x, y, sprite, xscale, yscale, angle = 0, color = c_white, alpha = 1, smoothing = false, smoothOffset = 100, smoothStep = 5) {
	draw_set_alpha(alpha);
	for (var i = 0; i < sprite_get_number(sprite); i++) {
		var yy = y - (i * step);
		var c = color;
		
		if (smoothing) {
			c = make_color_rgb(
				color_get_red(color) + smoothOffset + i * smoothStep,
				color_get_green(color) + smoothOffset + i * smoothStep,
				color_get_blue(color) + smoothOffset + i * smoothStep
			);
		}
		
		draw_sprite_ext(sprite, i, x, yy, xscale, yscale, angle, c, alpha);
	}
	draw_set_alpha(1);
}

function save_id(file, save, prettify = false) {
	var str = json_stringify(save, prettify);
	var buffer = buffer_create(string_byte_length(str)+1, buffer_fixed, 1);
	
	buffer_write(buffer, buffer_text, str);
	buffer_save(buffer, file);
	buffer_delete(buffer);
}

function color_lerp(col1, col2, t) {
    var r1 = color_get_red(col1);
    var g1 = color_get_green(col1);
    var b1 = color_get_blue(col1);

    var r2 = color_get_red(col2);
    var g2 = color_get_green(col2);
    var b2 = color_get_blue(col2);

    var r = lerp(r1, r2, t);
    var g = lerp(g1, g2, t);
    var b = lerp(b1, b2, t);

    return make_color_rgb(r, g, b);
}


// Code from Arend Peter Teaches
function get_perlin_noise_1D(xx, range){
	var noise = 0;
	var chunkSize = 8;
	var chunkIndex = xx div chunkSize;
	var prog = (xx % chunkSize) / chunkSize;

	var leftRandom = random_seed(chunkIndex, range);
	var rightRandom = random_seed(chunkIndex + 1, range);

	noise = (1-prog)*leftRandom + prog*rightRandom;

	return round(noise);
}


// Code from Arend Peter Teaches
function get_perlin_noise_2D(xx, yy, range, r = false){
	var chunkSize = 32 * 1;
	var noise = 0;

	range = range div 2;

	while (chunkSize > 0){
	  var index_x = xx div chunkSize;
	  var index_y = yy div chunkSize;
    
	  var t_x = (xx % chunkSize) / chunkSize;
	  var t_y = (yy % chunkSize) / chunkSize;
    
	  var r_00 = random_seed(range, index_x,   index_y);
	  var r_01 = random_seed(range, index_x,   index_y + 1);
	  var r_10 = random_seed(range, index_x+1, index_y);
	  var r_11 = random_seed(range, index_x+1, index_y + 1);
    
		var r_0 = lerp(r_00, r_01, t_y);
	  var r_1 = lerp(r_10, r_11, t_y);
   
	  noise += lerp(r_0, r_1, t_x);
    
	  chunkSize = chunkSize div 2;
	  range = range div 2;
	  range = max(1,range);
	}
	
	if (r) {
		return round(noise);
	}
	
	return noise;
}

// Code from Arend Peter Teaches
function random_seed(range){
	var num = 0;
	
	switch(argument_count) {
		case 2:
			num = argument[1];
			break;
		case 3:
			num = argument[1] + argument[2] * 12409172;
			break;
	}
	
	var seed = 0;
	seed += Seed + num;

	random_set_seed(seed);
	rand = random_range(0, range);

	return rand;
}

function rect(x, y, width, height, color = c_white, outline = false, alpha = 1, size = 1) {
	for (var i = 0; i < size; i++) {
		var step = 1;
		draw_set_alpha(alpha);
		draw_rectangle_color(
			x - width / 2 + i / step, 
			y - height / 2 + i / step, 
			x + width / 2 - i / step, 
			y + height / 2 - i / step, 
			color, color, color, color, outline
		);
		draw_set_alpha(1);
	}
}

function random_array_argument(array){
	if (is_array(array)) {
		return random_range(array[0], array[1]);
	}
	
	return array;
}


function opt(base, value) {
	var f = 60;
	
  if (value > f) value = f;
  else if (value < 0) value = 0;
    
  var factor = value / f;
  return base * factor;
}


function slider(val, x, y, width, height, handleWidth, color = c_white) {
	var handleX = (x + val) - width / 2;
	
	draw_line_color(x - width/2, y, x + width/2, y, color, color);
	
	button_gui(handleX, y, handleWidth, height, "", -1, true, color, c_white, 1, 1, function(){
		if (mouse_check_button(mb_left)) {
			var mx = window_mouse_get_x();
			var my = window_mouse_get_y();
	
			var pos = mx - x;
			
			return (pos);
		}
	}, BUTTON_ORIGIN.MiddleCenter);
	
}


function mkdir(path) {
	if (directory_exists(path)) {
		show_debug_message("./" + path + " already exists");
		return;
	}
}

function struct_merge(dest, src) {
	var keys = struct_get_names(src);
	for (var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		var val = variable_struct_get(src, key);
		struct_set(dest, key, val);
	}
}

function rope_create_point(_x, _y, _width = 2, color = c_green) {
  return {
    x: _x,
    y: _y,
    oldx: _x,
    oldy: _y,
		color: color,
		width: _width,
		children: [],
    pinned: false,
  };
}

function rope_update_point(p) {
  var vx = p.x - p.oldx;
  var vy = p.y - p.oldy;

  p.oldx = p.x;
  p.oldy = p.y;

  p.x += vx;
  p.y += vy + Gravity;
}

function rope_apply_constraint(p1, p2, length) {
  var dx = p2.x - p1.x;
  var dy = p2.y - p1.y;
  var dist = sqrt(dx*dx + dy*dy);
  var diff = (dist - length) / dist;
    
  var offsetX = dx * 0.5 * diff;
  var offsetY = dy * 0.5 * diff;

  if (!p1.pinned) {
    p1.x += offsetX;
    p1.y += offsetY;
  }
  if (!p2.pinned) {
    p2.x -= offsetX;
    p2.y -= offsetY;
  }
}


function raycast_to_collisions(x1, y1, x2, y2) {
    var nearest = noone;
    var nearest_dist = -1;

    var inst;
    with (Collision) {
        if (collision_line(x1, y1, x2, y2, id, false, true)) {
            var px = collision_line(x1, y1, x2, y2, id, false, true);
            var dist = point_distance(x1, y1, x, y);
            if (nearest == noone || dist < nearest_dist) {
                nearest = id;
                nearest_dist = dist;
            }
        }
    }

    return nearest;
}

function line_intersects_line(x1, y1, x2, y2, x3, y3, x4, y4) {
  var den = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));
  if (den == 0) return false;

  var t = ((x1 - x3) * (y3 - y4)) - ((y1 - y3) * (x3 - x4));
  var u = ((x1 - x3) * (y1 - y2)) - ((y1 - y3) * (x1 - x2));

  t /= den;
  u /= den;

  return (t >= 0 && t <= 1) && (u >= 0 && u <= 1);
}

function line_intersects_rect(x1, y1, x2, y2, rx1, ry1, rx2, ry2) {
  return (line_intersects_line(x1, y1, x2, y2, rx1, ry1, rx2, ry1) || // top
    line_intersects_line(x1, y1, x2, y2, rx2, ry1, rx2, ry2) || // right
    line_intersects_line(x1, y1, x2, y2, rx2, ry2, rx1, ry2) || // bottom
    line_intersects_line(x1, y1, x2, y2, rx1, ry2, rx1, ry1));   // left
}
