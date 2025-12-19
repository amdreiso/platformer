
cutscene = cutscene_create();
cutsceneLoop = true;

dialogue = [];
dialogueEnd = function(){}

talking = false;

spriteStates = {
	idle: -1,
	move: -1,
	talking: -1,
}


offset = new Vec2();
reach = false;

hsp = 0;
vsp = 0;
spd = 1;
isMoving = false;
knockback = new Vec2();

applyGravity = false;
collisions = [];

movement = function() {
	
	x += hsp;
	y += vsp;
	
	if (applyGravity) {
		vsp += Gravity;
	}
	
	isMoving = (hsp != 0 || vsp != 0);
	
}

applyCollisions = function() {
	for (var i = 0; i < array_length(collisions); i++) {
		collision_set(collisions[i]);
	}
}


draw = function() {
	var s = spriteStates.idle;
	
	if (isMoving) {
		s = spriteStates.move;
	}
	
	if (talking) {
		s = spriteStates.talking;
	}
	
	if (hsp != 0) {
		image_xscale = sign(hsp);
	}
	
	sprite_index = s;
	draw_self();
}



// Modifiers

setGravity = function(val) {
	applyGravity = val;
}

setCollisions = function() {
	for (var i = 0; i < argument_count; i++) {
		array_push(collisions, argument[i]);
	}
}

setSprite = function(idle, move, talking) {
	
	spriteStates.idle = idle;
	spriteStates.move = move;
	spriteStates.talking = talking;
	
}





