

enum BUTTON_ORIGIN {
	Left, 
	MiddleCenter,
}

function fovy(){
	show_debug_message("Loaded fovy!");
}

function approach(value, target, amount) {
  if (value < target) return min(value + amount, target)
  if (value > target) return max(value - amount, target)
  return value
}

function mouse_get_direction(x, y) {
	return point_direction(x, y, mouse_x, mouse_y);
}

function interval_set(obj, time, fn) {
	static tick = 0;
	static alltimetick = 0;
	
	tick += GameSpeed;
	alltimetick += GameSpeed;
	
	if (tick >= time) {
		tick = 0;
		fn(obj, alltimetick);
	}
}

function Registry() constructor {
	self.entries = ds_map_create();
	self.defaultComponents = {};
	
	static SetDefaultComponents = function(components) {
		self.defaultComponents = components;
	}
	
	static Register = function(val, components = {}) {
		var entry = {};
		entry.components = {};
		
		struct_merge(entry.components, self.defaultComponents);
		struct_merge(entry.components, components);
		
		self.entries[? val] = entry;
	}
	
	static Get = function(val) {
		return self.entries[? val] ?? undefined;
	}
	
	static GetType = function(val) {
		if (ds_map_exists(self.entries, val)) {
			if (!variable_struct_exists(self.entries[? val], "components")) return;
			return self.entries[? val].components.type;
		}
	}
}

function Callback() constructor {
	list = [];
	
	static Register = function(fn) {
		array_push(list, fn);
	}
	
	static Run = function(obj) {
		var len = array_length(list);
		for (var i = 0; i < len; i++) {
			list[i](obj);
			
			// End of callbacks
			if (i == len - 1) {
			}
		}
	}
}


function Stat(_value) constructor {
	
	value = _value;
	defaultValue = _value;
	
	static Sub = function(val) {
		value -= val;
	}
	
	static Add = function(val) {
		value += val;
	}
	
	static GetPercentage = function() {
		return (value / defaultValue) * 100;
	}
	
	static UpdateValue = function(val) {
		value = val;
		defaultValue = val;
	}
	
}


function show_object_status() {
	if (mouse_check_button_pressed(mb_left) && mouse_box_collision()) {
		log(object_get_name(object_index) + ": " + json_stringify(self, true));
	}
}

function mouse_box_collision() {
	var on = (mouse_x > bbox_left && mouse_x < bbox_right && mouse_y > bbox_top && mouse_y < bbox_bottom);
	return on;
}

function array_get_random(arr) {
	var index = irandom(array_length(arr) - 1);
	return arr[index];
}

function save_room_screenshot() {
	var filename = room_get_name(room) + ".png";
	
	// Make camera see the entire room 1:1 ratio
	var cam = camera_create_view(0, 0, room_width, room_height);
	
	view_set_visible(CAMERA_VIEWPORT_DEFAULT, false);
	view_set_visible(1, true);
	view_set_camera(1, cam);
	
	window_set_size(room_width, room_height);
	
	CameraViewport = 1;
	
	Player.isVisible = false;
	Settings.graphics.drawUI = false;
	
	screen_save(filename);
	
	print($"Screenshot saved as {filename}");
	
	CameraViewport = 0;
}

function position_get(o) {
	return new Vec2(o.x, o.y);
}

function angle_lerp(a, b, t) {
    var diff = angle_difference(b, a);
    return a + diff * t;
}

function file_load(filename) {
	var file = filename;
	var buffer = buffer_load(file);
	var con = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	return con;
}

function string_pad(str, val) {
	while (string_length(str) < val) str+=" ";
	return str;
}

function format_number(n) {
	if (n >= 1_000_000_000) return string_format(n / 1_000_000_000, 0, 1) + "B";
	if (n >= 1_000_000) return string_format(n / 1_000_000, 0, 1) + "M";
	if (n >= 1_000) return string_format(n / 1_000, 0, 1) + "K";
	return string(n);
}

function merge_struct_into_instance(target, struct) {
  var keys = variable_struct_get_names(struct);
	
  for (var i = 0; i < array_length(keys); i++) {
		var index = struct_get(struct, keys[i]);
		
		if (is_method(index)) {
			var value = index();
			struct_set(struct, keys[i], value);
		}
		
    variable_instance_set(target, keys[i], index);
	}
	
}

function color_invert(color) {
  var r = 255 - color_get_red(color);
  var g = 255 - color_get_green(color);
  var b = 255 - color_get_blue(color);
  return make_color_rgb(r, g, b);
}

function color_darkness(color, value) {
	var hue = color_get_hue(color);
	var sat = color_get_saturation(color);
	var val = color_get_value(color) - value;
	return make_color_hsv(hue, sat, val);
}

function position_tolerance(xx, yy, tolerance) {
	var t = tolerance;
	return (x > xx - t && x < xx + t && y > yy - t && y < yy + t);
}

function on_last_frame(fn) {
	if (ceil(image_index) == sprite_get_number(sprite_index)) {
		fn();
		return true;
	}
	return false;
}

function knockback_apply() {
	var knockbackFallout = 0.20;
	
	//if (round(knockback.x) != 0) knockback.x += ( -sign(knockback.x) * knockbackFallout * GameSpeed ); else knockback.x = 0;
	//if (round(knockback.y) != 0) knockback.y += ( -sign(knockback.y) * knockbackFallout * GameSpeed ); else knockback.y = 0;
	
	knockback.x = approach(knockback.x, 0, knockbackFallout);
	knockback.y = approach(knockback.y, 0, knockbackFallout);
}

//function apply_force() {
//  var decel = FORCE_DECELERATION * GameSpeed;

//  if (abs(force.x) <= decel) {
//    force.x = 0;
//  } else {
//    force.x -= decel * sign(force.x);
//  }

//  if (abs(force.y) <= decel) {
//    force.y = 0;
//  } else {
//    force.y -= decel * sign(force.y);
//  }
//}

function collision_set(obj, subpixel = 1) {
	if (!instance_exists(obj)) return;
	
	var sp = 1;
	
	var fx = knockback.x;
	var fy = knockback.y;
	
	fx = 0; fy = 0;
	
	if (place_meeting(x + hsp + fx, y, obj)) {
		
		// Slope up
		if (!place_meeting(x + hsp, y - abs(hsp) - 1, obj)) {
			
			while (place_meeting(x + hsp, y, obj)) {
				y -= sp;
			}
			
		} else {
 			
			while (!place_meeting(x + sign(hsp + fx), y, obj)) {
				x = x + sign(hsp + fx);
			}
			
			hsp = 0;
			knockback.x = 0;
		}
	}
	
	if (place_meeting(x, y + vsp + fy, obj)) {
		while (!place_meeting(x, y + sign(vsp + fy), obj)) {
			y = y + sign(vsp + fy);
		}
		
		vsp = 0;
		knockback.y = 0;
	}
	
}

function isometric_position(x, y) {
	var x0, y0, xoffset = 0;
	var w = TILE_WIDTH;
	var h = TILE_HEIGHT - 4;
	
	if (y % 2 == true) then xoffset = w / 2;
			
	x0 = (x * w) + xoffset;
	y0 = (y * (h / 2));
	
	return new Vec2(x0, y0);
}

function Vec2(x=0, y=0) constructor {
	self.x = x;
	self.y = y;
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

function Dim(width=0, height=0) constructor {
	self.width = width;
	self.height = height;
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
					//set_cursor(CURSOR.Pointer);
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

function button_clear(
	x, y, width, height, fn = function(){}
) {
	var range = (mouse_x > x && mouse_x < x + width && mouse_y > y && mouse_y < y + height);
	if (range) fn();
}

function button_clear_gui(
	x, y, width, height, fn = function(){}
) {
	var mx = window_mouse_get_x();
	var my = window_mouse_get_y();
	var range = (mx > x && mx < x + width && my > y && my < y + height);
	if (range) fn();
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
					window_set_cursor(cr_handpoint);
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
function get_perlin_noise_2D(xx, yy, range, r = false, chunksize = 1){
	var chunkSize = 64 * chunksize;
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
	  range = max(1, range);
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
	seed += World.seed + num;

	random_set_seed(seed);
	var rand = random_range(0, range);

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
	directory_create(path);
}

function struct_merge(dest, src) {
	var keys = struct_get_names(src);
	for (var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		var val = variable_struct_get(src, key);
		struct_set(dest, key, val);
	}
}

function struct_merge_recursive(default_struct, loaded_struct) {
  var names = struct_get_names(loaded_struct);
  for (var i = 0; i < array_length(names); i++) {
    var key = names[i];
    var loaded_val = struct_get(loaded_struct, key);

    if (variable_struct_exists(default_struct, key) && is_struct(struct_get(default_struct, key)) && is_struct(loaded_val)) {
      struct_merge_recursive(struct_get(default_struct, key), loaded_val);
    } else {
      struct_set(default_struct, key, loaded_val);
    }
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
