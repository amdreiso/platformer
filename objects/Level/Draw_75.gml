
if (!Settings.graphics.drawUI) return;

//drawBossbar();
drawScreenFlash();


if (Settings.graphics.drawScanlines) {
	var size = 4;
	for (var i = 0; i < HEIGHT / size; i++) {
		draw_set_alpha(0.25);
		draw_line_width_color(0, i * size, WIDTH, i * size, 2, c_black, c_black);
		draw_set_alpha(1);
	}
}


//showLevelName = max(0, showLevelName - 1);
//if (showLevelName) {
//	var level = LEVEL.Get(room).components;
//	var margin = 50;
//	draw_set_halign(fa_left);
//	draw_text_outline(margin, HEIGHT - margin, level.name, 1, 1, 0, 1, fnt_console_GUI, c_black, c_white);
	
//	draw_set_halign(fa_center);
//}