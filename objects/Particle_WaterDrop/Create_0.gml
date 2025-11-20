
event_inherited();

sprite = sParticle_Waterdrop;
randomSprite = true;

gravityForce = 0.05;
gravityApply = true;
lifetime = 180;

force = 0.3;

hsp += random_range(0.50, 1.50) * choose(-1, 1) * force;
vsp -= random_range(0.50, 1.50) * force;

image_angle = 0;
