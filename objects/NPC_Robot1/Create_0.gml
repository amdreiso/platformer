
event_inherited();

dialogue = [
	"[shake=0.25]bzzt... bzzt...[/shake]",
];

alarm[0] = 1;

offset.y = -sprite_get_height(sprite_index);

destroyed = false;

isFixed = true;

spriteStates.idle = sRobot1;
spriteStates.move = sRobot1;
spriteStates.talking = sRobot1_talking;
