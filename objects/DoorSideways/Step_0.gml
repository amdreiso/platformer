
var requirements = (Player.soul == soulType);

if (distance_to_object(Player) < 10 && openable && requirements) {
	open = true;
	tick = 0;
} else {
	tick += GameSpeed;
}

if (open) {
	
	image_speed = 1;
	on_last_frame(function(){ 
		image_speed = 0;
	});
	
	if (tick > 0.05 * 60) {
		open = false;
	}
	
} else {
	
	if (floor(image_index) > 0) {
		image_index -= 0.2;
	} else {
		image_speed = 0;
		
		if (Player.x < x) {
			image_xscale *= -1;
		} else {
			image_xscale *= 1;
		}
	}
	
	
}


