
event_inherited();


// Unique
offset = new Vec2(-24, -24);
alarm[0] = choose(3, 5, 7, 9, 11) * 60;

flyTime = 0.01;
flyAmplitude = 1;


// Collisions
collisions = [ Collision ];


// Draw
spriteStates.Set("idle", sMob_Fly, function(){
	return (hsp == 0 && vsp == 0);
});

spriteStates.Set("move", sMob_Fly, function(){
	return (isMoving);
});

draw.Register(function(){
	var sprite = spriteStates.Get();
	
	sprite_index = sprite;
	draw_self();
});
