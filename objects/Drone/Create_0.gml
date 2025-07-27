
event_inherited();

spriteStates.idle = sDrone;
spriteStates.move = sDrone;

applyGravity = false;

weaponSprite = -1;

alarm[0] = 160;

spd = 3;

target = vec2(Player.x, Player.y);
follow = true;
sleepCooldown = 40;
sleep = sleepCooldown;

damage = 10;
