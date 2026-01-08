
event_inherited();

lightAlpha = 0.33;
lightLevel = 100;

drops.Add(ITEM_ID.Gold, 0.5, 1);

spd = 0.66;
hasSeenPlayer = false;

tick = 0;

spriteStates.idle = sThrower_Idle_Enemy;
spriteStates.move = sThrower_Move_Enemy;

projdamage = 5;

radius = 70;

setHp(5);

throwTime = 70;
thrown = false;
thrownCooldown = 0;
throwCount = 0;
throwForce = 1;

