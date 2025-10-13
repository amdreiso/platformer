
if (instance_number(Particle) >= Settings.graphics.maxParticlesOnScreen) {
	instance_destroy();
}

hsp = 0;
vsp = 0;

gravityApply = false;
gravityForce = 0.1;

angle = 0;
theta = 0;

tick = 0;
lifetime = 1000;
destroy = false;

xscale = 1;
yscale = 1;
scale = 1;
scaleFactor = 0;

color = c_white;

image_angle = irandom(360);

sprite = -1;
getRandomSprite = false;

alpha = 1;

fadein = false; fadeinSpeed = 0.01;
fadeout = false; fadeoutSpeed = 0.01;


