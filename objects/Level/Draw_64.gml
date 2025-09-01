
drawBossbar();
drawScreenFlash();

if (Settings.graphics.drawScanlines) {
	var size = 4;
	for (var i = 0; i < HEIGHT / size; i++) {
		draw_set_alpha(0.25);
		draw_line_width_color(0, i * size, WIDTH, i * size, 2, c_black, c_black);
		draw_set_alpha(1);
	}
}
