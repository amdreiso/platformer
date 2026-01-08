

if (reach) {
	draw_outline(1, 0, Style.outlineColor);
} else {
	draw_self();
}

if (active) {
	draw_text_outline(x, y - 48, savingString, 1, 1, 0, 1, fnt_console);
}
