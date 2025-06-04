
x += hsp;
y += vsp;

if (gravityApply) {
	vsp += gravityForce;
}

tick += GameSpeed;

if (tick >= lifetime) {
	destroy = true;
	
	if (!fadeout) instance_destroy();
}


// Fadein
if (fadein && !destroy) {
	alpha = max(0, alpha + fadeinSpeed);
}


// Fadeout
if (destroy) {
	
	
	alpha = max(0, alpha - fadeoutSpeed);
	
	if (alpha == 0) {
		instance_destroy();
	}
}
