

moveCycle = [];


dialogue = [
];
dialogueEnd = function(){}

talking = false;

idleSprite = sprite_index;
talkingSprite = sprite_index;

offset = vec2();
reach = 30;
reachDistance = 30;

hsp = 0;
vsp = 0;
spd = 1;

movement = function() {
	
	x += hsp;
	y += vsp;
	
}
