function textbox(){

}

function TextChar(_char, _color, _shake, _scale = 0.5, _spd = 10, _font = fnt_console, _angle = 0) {
  return {
    char: _char,
    color: _color,
    shake: _shake,
		scale: _scale,
		spd: _spd,
		angle: _angle,
		font: _font,
  };
}


function parse_rich_text(input) {
  var result = [];
  var color = c_white;
  var shake = false;
	var defaultScale = 0.33;
	var scale = defaultScale;
	var spd = 10;
  var i = 1;
	var angle = 0;
  var font = fnt_console;
	
  while (i <= string_length(input)) {
    if (string_char_at(input, i) == "[") {
			var _end = i;
			while (_end <= string_length(input) && string_char_at(input, _end) != "]") {
			  _end ++;
			}
			if (_end > string_length(input)) break;
			
      var tag = string_copy(input, i + 1, _end - i - 1);
            
      // Handle tags
      if (string_starts_with(tag, "color=")) {
        var col = string_delete(tag, 1, 6);
				if (string_char_at(col, 1) == "#") {
	        // Parse hex color
	        var hex = string_delete(col, 1, 1); // remove the #
	        if (string_length(hex) == 6) {
	          var r = real("0x" + string_copy(hex, 1, 2));
	          var g = real("0x" + string_copy(hex, 3, 2));
	          var b = real("0x" + string_copy(hex, 5, 2));
	          color = make_color_rgb(r, g, b);
	        } else {
	          color = c_white;
	        }
				} else {
	        switch (col) {
	          case "red": color = c_red; break;
	          case "blue": color = c_blue; break;
	          case "green": color = c_lime; break;
	          default: color = c_white;
	        }
				}
      } else if (tag == "/color") {
        color = c_white;
      } else if (string_starts_with(tag, "shake=")) {
				var shakeValue = string_delete(tag, 1, 6);
        shake = real(shakeValue);
      } else if (tag == "/shake") {
        shake = 0;
      } else if (string_starts_with(tag, "scale=")) {
				var s = string_delete(tag, 1, 6);
				scale = real(s);
			} else if (tag == "/scale") {
				scale = defaultScale;
			} else if (string_starts_with(tag, "angle=")) {
				var a = string_delete(tag, 1, 6);
				angle = real(a);
			} else if (tag == "/angle") {
				angle = 0;
			} else if (string_starts_with(tag, "speed=")) {
				spd = real(string_delete(tag, 1, 6));
			} else if (tag == "/speed") {
				spd = 10;
			} else if (string_starts_with(tag, "italic")) {
				font = fnt_console_italic;
			} else if (tag == "/italic") {
				font = fnt_console;
			}
      i = _end + 1;
    } else {
			var char = TextChar(string_char_at(input, i), color, shake, scale, spd, font, angle);
      array_push(result, char);
      i++;
    }
  }
  return result;
}