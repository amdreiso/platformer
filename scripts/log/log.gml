function log(str, color = c_ltgray, font = fnt_console) {
	if (!instance_exists(Main)) return;
	
	var slices = string_split(str, "\n");
	
	for (var i = 0; i < array_length(slices); i++) {
		array_insert(Main.logs, 0, {
			str: slices[i],
			color: color,
			font: font,
		});
	}
}

function err(str) {
	if (!instance_exists(Main)) return;
	
	array_insert(Main.logs, 0, {
		str: "err: "+str,
		color: c_red,
		font: fnt_console_bold,
	});
}