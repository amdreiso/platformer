function draw_debug_gui(){
	
	if (!Debug.debug) return;
	
	var scale = 1.5;
	var height = 12 * scale;
	var fore = c_white;
	var back = c_black;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var version = $"{ GameInfo.version[0] }.{ GameInfo.version[1] }";
	
	draw_text_outline(0, 0 * height, $"{GameInfo.name} {version} made by {GameInfo.author}", scale, scale, 0, 1, fnt_console, back, fore);
	
	draw_text_outline(0, 1 * height, $"fps {fps}", scale, scale, 0, 1, fnt_console, back, fore);
	
	var p = vec2(), c = vec2(), pdir = vec2(), t = vec2();
	if (instance_exists(Player)) p = position_get(Player) pdir = vec2(Player.hsp, Player.vsp) t = Player.tilePosition;
	if (instance_exists(Camera)) c = position_get(Camera);
	
	draw_text_outline(0, 2 * height, $"px {p.x} py {p.y} | hsp {pdir.x} vsp {pdir.y} | tx {t.x} ty {t.y}", scale, scale, 0, 1, fnt_console, back, fore);
	
	draw_text_outline(0, 3 * height, $"cx {c.x} cy {c.y}", scale, scale, 0, 1, fnt_console, back, fore);
	
	
	if (Debug.drawAttackCommandInput) {
		draw_set_halign(fa_right);
		var margin = 20;
		draw_text(WIDTH - margin, HEIGHT - margin, Player.attackCommandInput);
		draw_set_halign(fa_center);
	}
	
}