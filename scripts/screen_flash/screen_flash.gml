function screen_flash(alpha, time, color=c_white){
	
	if (!instance_exists(Level)) return;
	
	Level.screen.flashAlpha			= alpha;
	Level.screen.flashTime			= time;
	Level.screen.flashColor			= color;
	
}