

alpha = 0;
boxSubtract = vec2();

draw = function() {
	
	var x0 = WIDTH / 2;
	var y0 = HEIGHT / 2;
	
	var size = dim(200, 400);
	
	
	// Animations
	var openingSpeed = 0.25;
	var closingSpeed = 0.25;
	
	if (Paused) {
		
		alpha = lerp(alpha, 1, openingSpeed);
		boxSubtract = lerp(boxSubtract, 0, openingSpeed);
		
	} else {
		
		alpha = lerp(alpha, 0, closingSpeed);
		boxSubtract = lerp(boxSubtract, 0, openingSpeed);
		
	}
	
	
	draw_set_alpha(alpha);
	
	var bg = Style.backgroundColor;
	
	draw_rectangle_color(
		x0 - size.width / 2, y0 - size.height / 2, 
		x0 + size.width / 2, y0 + size.height / 2, 
		bg, bg, bg, bg, false
	);
	
	draw_set_alpha(1);
	
}

