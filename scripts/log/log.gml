function log(str, color = c_ltgray, font = fnt_console) {
	if (!instance_exists(Main)) return;
	
	array_insert(Main.logs, 0, {
		str: str,
		color: color,
		font: font,
	});
}

function err(str) {
	if (!instance_exists(Main)) return;
	
	array_insert(Main.logs, 0, {
		str: "err: "+str,
		color: c_red,
		font: fnt_console_bold,
	});
}