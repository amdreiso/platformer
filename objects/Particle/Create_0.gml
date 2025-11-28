
if (instance_number(Particle) >= Settings.graphics.maxParticlesOnScreen) {
	instance_destroy();
}

hsp = 0;
vsp = 0;

knockback = new Vec2();

collisions = [];

gravityApply = false;
gravityForce = 0.1;

angle = 0;
theta = 0;
roll = false;

tick = 0;
lifetime = 1000;
destroy = false;

updateCallback = new Callback();

xscale = 1;
yscale = 1;
scale = 1;
scaleFactor = 0;

color = c_white;

image_angle = irandom(360);

sprite = -1;

randomSprite = false;
randomSpriteCallback = new Callback();

alpha = 1;

fadein = false; fadeinSpeed = 0.01;
fadeout = false; fadeoutSpeed = 0.01; fadeoutCooldown = 0;
