
event_inherited();

spriteStates.idle = sDrone;
spriteStates.move = sDrone;

applyGravity = false;

weaponSprite = -1;

spd = 2.33;

setHp(5);

target = vec2(Player.x, Player.y);
follow = true;
sleepCooldown = 20;
sleep = sleepCooldown;

damage = 10;

applyGroundCollisions = false;
sound = -1;


