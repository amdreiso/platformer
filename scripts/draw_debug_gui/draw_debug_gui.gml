function draw_debug_gui(){
	
	if (!Debug.debug) return;
	
	draw_line(WIDTH / 2, 0, WIDTH / 2, HEIGHT);
	draw_line(0, HEIGHT / 2, WIDTH, HEIGHT / 2);
	
	draw_set_alpha(0.5);
	draw_rectangle_colour(0, 0, 400, HEIGHT / 2, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	
	var scale = 1;
	var height = 18 * scale;
	var fore = c_white;
	var back = c_black;
	var font = fnt_main_debug;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var version = $"{ GameInfo.version.major}.{ GameInfo.version.minor} {GameInfo.build}";
	
	draw_text_outline(0, 0 * height, $"{GameInfo.name} {version} made by {GameInfo.author}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 1 * height, $"fps {1000000 / delta_time}", scale, scale, 0, 1, font, back, fore);
	
	var p = new Vec2(), c = new Vec2(), pdir = new Vec2(), t = new Vec2(), onGround = 0;
	p = position_get(Player) pdir = new Vec2(Player.hsp, Player.vsp) t = Player.tilePosition onGround = Player.onGround;
	if (instance_exists(Camera)) c = position_get(Camera);
	
	draw_text_outline(0, 2 * height, $"px {p.x} py {p.y} onGround {onGround} jumps {Player.jumpCount}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 3 * height, $"hsp {pdir.x} vsp {pdir.y}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 4 * height, $"hspTotal {Player.hspTotal} vspTotal {Player.vspTotal}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 5 * height, $"kx {Player.knockback.x} ky {Player.knockback.y}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 6 * height, $"tx {t.x} ty {t.y}", scale, scale, 0, 1, font, back, fore);
	draw_text_outline(0, 7 * height, $"cx {c.x} cy {c.y}", scale, scale, 0, 1, font, back, fore);
	
	if (Debug.drawAttackCommandInput) {
		draw_set_halign(fa_right);
		var margin = 20;
		draw_text(WIDTH - margin, HEIGHT - margin, Player.attackCommandInput);
		draw_set_halign(fa_center);
	}
	
	if (Debug.displayLevelSignals) {
		
		var c0 = c_black;
		draw_rectangle_colour(0, 300, 300, 650, c0, c0, c0, c0, false);
		
		for (var i = 0; i < array_length(Level.signals.list); i++) {
			
			var s = Level.signals.list[i];
			var h = 12;
			
			draw_set_halign(fa_left);
			
			draw_text(0, 300 + i * h, $"signalID: {s.signalID} | time: {s.time}");
			
			draw_set_halign(fa_center);
			
		}
		
	}
	
	
	
}