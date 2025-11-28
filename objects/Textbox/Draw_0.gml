
depth = layer_get_depth(layer_get_id("Textbox"));

var totalWidth = 0;
textTimer += delta_time / 1000000;

if (text == 0) {
	text = parse_rich_text(dialogue[0]);
}

var spacebarScale = 1;
var spacebarColor = c_white;

for (var i = 0; i < charCount; i++) {
	var tc = text[i];
	totalWidth += string_width(tc.char) * tc.scale;
}

var xoffset = -totalWidth / 2;

for (var i = 0; i < charCount; i++) {
  var tc = text[i];
  
  var dx = x + xoffset;
  var dy = y - (string_height(tc.char) / 2 * tc.scale);
  
	var waveStep = i * tc.scale;
	var waveTime = (current_time + i * 100);
	
  dx += random_range(-tc.shake, tc.shake) + sin(waveTime * tc.waveTime) * tc.waveAmp;
  dy += random_range(-tc.shake, tc.shake) + sin(waveTime * tc.waveTime) * tc.waveAmp;
  
	textSpeed = tc.spd;
	
	var shadowOffset = tc.scale;
	var shadowColor = c_black;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	draw_set_font(tc.font);
	
	draw_rectangle_color(dx, dy, dx + string_width(tc.char) * tc.scale, dy + string_height(tc.char) * tc.scale, c_black, c_black, c_black, c_black, false);
	
  draw_text_transformed_color(dx + shadowOffset, dy + shadowOffset, tc.char, tc.scale, tc.scale, tc.angle, shadowColor, shadowColor, shadowColor, shadowColor, 1);
  draw_text_transformed_color(dx, dy, tc.char, tc.scale, tc.scale, tc.angle, tc.color, tc.color, tc.color, tc.color, 1);
	
	draw_set_font(tc.font);
	
  xoffset += string_width(tc.char) * tc.scale;
	
	spacebarScale = tc.scale / 1;
	//spacebarColor = tc.color;
}


var advance = Keymap.player.jump;

if (charCount < array_length(text)) {
  
	if (textTimer >= 1 / textSpeed) {
    textTimer = 0;
    charCount ++;
		
		if (sound != -1) {
			var p = random_array_argument(pitch);
			audio_play_sound(snd_textbox1, 0, false, 1, 0, p);
		}
  }
	
	if (advance) {
		charCount = array_length(text);
	}
	
} else {
	
	if (advance) {
		var len = array_length(dialogue) - 1;
		Level.screenlog("Textbox: " + string(index) + " / " + string(len) + " texts");
		
		if (index < len) {
			index ++;
			text = parse_rich_text(dialogue[index]);
			charCount = 0;
		} else {
			instance_destroy();
		}
	}
	
	var spr = sButton_Spacebar;
	if (CurrentController == CONTROLLER_INPUT.Gamepad) spr = sButton_Cross;
	
	var magicnumber0 = 10 * spacebarScale;
	draw_sprite_ext(spr, current_time * 0.005, x + xoffset + magicnumber0, y + magicnumber0, spacebarScale, spacebarScale, sin(current_time * 0.01) * 4, spacebarColor, 1);
	
}

