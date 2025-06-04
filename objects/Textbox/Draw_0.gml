
depth = -99999999999;

textTimer += delta_time / 1000000;


if (charCount < array_length(text)) {
  
	if (textTimer >= 1 / textSpeed) {
    textTimer = 0;
    charCount ++;
  }
	
	if (keyboard_check_pressed(vk_space)) {
		charCount = array_length(text);
	}
	
} else {
	
	if (keyboard_check_pressed(vk_space)) {
		if (index < array_length(dialogue)-1) {
			index ++;
			text = parse_rich_text(dialogue[index]);
			charCount = 0;
		} else {
			instance_destroy();
		}
	}
	
}

var totalWidth = 0;

for (var i = 0; i < charCount; i++) {
	var tc = text[i];
  totalWidth += string_width(tc.char) / tc.scale * tc.scale;
}

var xOffset = -totalWidth / 2;

for (var i = 0; i < charCount; i++) {
  var tc = text[i];
  
  var dx = x + xOffset * tc.scale;
  var dy = y;
  
  dx += random_range(-tc.shake, tc.shake);
  dy += random_range(-tc.shake, tc.shake);
  
	textSpeed = tc.spd;
	
	var shadowOffset = tc.scale;
	var shadowColor = c_black;
	
	draw_set_font(tc.font);
	
  draw_text_transformed_color(dx+shadowOffset, dy+shadowOffset, tc.char, tc.scale, tc.scale, tc.angle, shadowColor, shadowColor, shadowColor, shadowColor, 1);
  draw_text_transformed_color(dx, dy, tc.char, tc.scale, tc.scale, tc.angle, tc.color, tc.color, tc.color, tc.color, 1);
	
	draw_set_font(tc.font);
	
  xOffset += string_width(tc.char);
}
