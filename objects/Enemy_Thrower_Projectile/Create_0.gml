
event_inherited();

hsp = 0;
vsp = 0;
angle = 0;
force = new Vec2();

destroyOnCollisions = false;
destroyOnPlayerAttack = true;

sprite_index = sThrower_Projectiles;
image_speed = 0;
image_index = irandom(sprite_get_number(sprite_index));

lifetime = 3 * 60;

scale = choose(1.25, 1.5, 1.75, 2);
