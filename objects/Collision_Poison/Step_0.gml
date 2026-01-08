
tick += GameSpeed;

if (tick > time) {
	tick = 0;
	time = choose(10, 20, 30);
	
	repeat (irandom(1) + 1) {
		var pos = new Vec2(
			x, y
		);
		
		var width = sprite_width;
		var height = sprite_height;
		
		pos.x += irandom(width);
		pos.y += irandom(height);
		
		create_poison_particles( pos );
		
	}
}
