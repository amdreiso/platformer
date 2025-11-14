
x += hsp * GameSpeed;
y += vsp * GameSpeed;

scale += scaleFactor * GameSpeed;
scale = max(0, scale);

angle += theta * GameSpeed;

if (gravityApply) {
	vsp += gravityForce;
}

tick += GameSpeed;

if (round(tick) >= lifetime) {
	destroy = true;
	if (!fadeout) then instance_destroy();
}


// Fadein
if (fadein && !destroy) {
	alpha = clamp(alpha + fadeinSpeed * GameSpeed, 0, 1);
}

if (fadeout) {
	alpha = clamp(alpha - fadeoutSpeed * GameSpeed, 0, 1);
	
	if (alpha == 0) destroy = true;
}


// Fadeout
if (destroy) {
	alpha = clamp(alpha - fadeoutSpeed * GameSpeed, 0, 1);
	
	if (alpha == 0) {
		instance_destroy();
	}
}


updateCallback.Run(self);

