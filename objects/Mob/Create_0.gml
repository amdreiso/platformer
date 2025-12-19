
// Movement
spd = 1;
hsp = 0;
vsp = 0;
knockback = new Vec2();
isMoving = false;


// Collisions
collisions = [];

applyCollisions = function() {
	for (var i = 0; i < array_length(collisions); i++) {
		collision_set(collisions[i]);
	}
}


// Draw
spriteStates = new SpriteStates();


draw = new Callback();

draw.Register(function(){
	if (hsp != 0) then image_xscale = sign(hsp);
});

//draw = function() {
//	if (hsp != 0) then image_xscale = sign(hsp);
//}


