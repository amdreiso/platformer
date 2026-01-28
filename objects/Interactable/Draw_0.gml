
if (Debug.debug) {
	draw_set_halign(fa_center);
	
	var scale = 0.5;
	
	draw_text_outline(x, y - 16, $"active: {bool_string(active)}", scale, scale, 0, 1, fnt_main);
	draw_text_outline(x, y - 24, $"signalID: {signalID}", scale, scale, 0, 1, fnt_main);
}
