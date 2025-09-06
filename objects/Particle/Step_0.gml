
x += hsp;
y += vsp;

scale += scaleFactor;
scale = max(0, scale);

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

if (fadeout) {
	alpha = max(0, alpha - fadeoutSpeed);
	
	if (alpha == 0) destroy = true;
}


// Fadeout
if (destroy) {
	alpha = max(0, alpha - fadeoutSpeed);
	
	if (alpha == 0) {
		instance_destroy();
	}
}

