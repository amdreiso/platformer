
event_inherited();

sprite = sParticle_Explosion;
index = irandom(sprite_get_number(sprite) - 1);

gravityApply = false;
lifetime = random_range(0.10, 1.00) * 10;

image_angle = 0;

fadeout = true;
fadeoutSpeed = 0.5;

force = randvec2(0, 0, random_range(0.50, 2.00));

var t = 50.00;
theta = random_range(-t, t);

spd = 0.05;
hdir = random_range(-1.00, 1.00);
vdir = random_range(-1.00, 1.00) / 2;

color = choose(c_red, c_yellow);
size = random_range(0.5, 8.0);

angle = irandom(360);

scale = random_range(0.30, 1.00);

xscale = choose(-1, 1);
yscale = choose(-1, 1);
