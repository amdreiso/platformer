function draw_debug_gui(){
	
	if (!Debug.debug) return;
	
	var scale = 1;
	var height = 18 * scale;
	var fore = c_white;
	var back = c_black;
	var font = fnt_console_GUI;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var version = $"{ GameInfo.version[0]}.{ GameInfo.version[1]}";
	
	draw_text_outline(0, 0 * height, $"{GameInfo.name} {version}v made by {GameInfo.author}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 1 * height, $"fps {fps}", scale, scale, 0, 1, font, back, fore);
	
	var p = new Vec2(), c = new Vec2(), pdir = new Vec2(), t = new Vec2(), onGround = 0;
	p = position_get(Player) pdir = new Vec2(Player.hsp, Player.vsp) t = Player.tilePosition onGround = Player.onGround;
	if (instance_exists(Camera)) c = position_get(Camera);
	
	draw_text_outline(0, 2 * height, $"px {p.x} py {p.y} onGround {onGround} jumps {Player.jumpCount}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 3 * height, $"hsp {pdir.x} vsp {pdir.y} | tx {t.x} ty {t.y}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 4 * height, $"cx {c.x} cy {c.y}", scale, scale, 0, 1, font, back, fore);
	
	if (Debug.drawAttackCommandInput) {
		draw_set_halign(fa_right);
		var margin = 20;
		draw_text(WIDTH - margin, HEIGHT - margin, Player.attackCommandInput);
		draw_set_halign(fa_center);
	}
	
	draw_line(WIDTH / 2, 0, WIDTH / 2, HEIGHT);
	draw_line(0, HEIGHT / 2, WIDTH, HEIGHT / 2);
	
}