
event_inherited();

sprite = sParticle_Attack;

randomSprite = true;
randomSpriteCallback.Register(function(obj){
	if (obj.image_index == sprite_get_number(obj.sprite) - 1) return;
	obj.angle = irandom(360);
});

gravityApply = false;
lifetime = 60;
fadeout = true;
fadeoutSpeed = 0.05;

scale = random_range(1.20, 1.55);
scaleFactor = 0.01;
