

// Transition
if (transition) {
	transitionAlpha += transitionTime;
	
	if (transitionAlpha >= 1) {
		transition = false;
		room_goto(transitionOutput);
		player_set_pos(transitionPlayerPosition);
		transitionOnEnter();
	}
} else {
	transitionAlpha = max(0, transitionAlpha - transitionTime);
}

draw_set_alpha(transitionAlpha);
var c0 = transitionColor;
draw_rectangle_color(0, 0, window_get_width(), window_get_height(), c0, c0, c0, c0, false);
draw_set_alpha(1);


if (Debug) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var version = string(GameInfo.version[0]) + string(GameInfo.version[1]);
	var fs = 18;
	var margin = 5;
	
	draw_set_font(fnt_dev);
	
	draw_set_font(fnt_main);
}


drawConsole();
