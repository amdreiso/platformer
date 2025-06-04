function log(str, color = c_ltgray, font = fnt_console) {
	if (!instance_exists(Main)) return;
	
	if (array_length(Main.logs) > 24) {
		array_delete(Main.logs, array_length(Main.logs)-1, 1);
	}
	
	var finalString = str;
	
	// Breaklines
	for (var i = 0; i < string_length(str); i++) {
		if (string_char_at(str, i) == "\n") {
			var cringe = string_delete(str, i, 2);
			var rest = string_copy(cringe, i, string_length(cringe));
			var copy = string_copy(cringe, 0, i);		// talvez copie um caractere a mais, i-1?
			
			log(copy);
			log(rest);
			
			return;
		}
	}
	
	array_insert(Main.logs, 0, {
		str: finalString,
		color: color,
		font: font,
	});
}