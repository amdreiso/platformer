
x += hsp * GameSpeed;
y += vsp * GameSpeed;

scale += scaleFactor * GameSpeed;
scale = max(0, scale);

angle += theta * GameSpeed;

if (gravityApply) {
	vsp += gravityForce;
}

tick += GameSpeed;

if (tick >= lifetime) {
	destroy = true;
	
	if (!fadeout) then instance_destroy();
}


// Fadein
if (fadein && !destroy) {
	alpha = max(0, (alpha + fadeinSpeed) * GameSpeed);
}

if (fadeout) {
	alpha = max(0, (alpha - fadeoutSpeed) * GameSpeed);
	
	if (alpha == 0) destroy = true;
}


// Fadeout
if (destroy) {
	alpha = max(0, (alpha - fadeoutSpeed) * GameSpeed);
	
	if (alpha == 0) {
		instance_destroy();
	}
}

