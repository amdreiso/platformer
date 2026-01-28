
x += hsp * knockback.x * GameSpeed;
y += vsp * knockback.y * GameSpeed;

if (hspFactor != 0) then hsp = lerp(hsp, hspTarget, hspFactor);
if (vspFactor != 0) then vsp = lerp(vsp, vspTarget, vspFactor);

knockback_apply();

if (roll) {
	var vel = (hsp * knockback.x);
	var r = sprite_width / 2;
	var circumference = r * 2 * pi;
	var change = (vel / circumference) * 360;

	angle -= change / 1.5;
}

scale += scaleFactor * GameSpeed;
scale = max(0, scale);

angle += theta * GameSpeed;

if (gravityApply) {
	vsp += gravityForce;
}


for (var i = 0; i < array_length(collisions); i++) {
	collision_set(collisions[i]);
	
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

fadeoutCooldown = max(0, fadeoutCooldown - GameSpeed);
if (fadeout && fadeoutCooldown == 0) {
	if (round(tick) < lifetime) return;
	
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


if (!camera_in_bounds(x, y)) {
	instance_destroy();
}