
event_inherited();

sprite = sParticle_Attack;

randomSprite = true;
randomSpriteCallback.Register(function(obj){
	var num = sprite_get_number(obj.sprite);
	
	obj.image_index = irandom(num - 2);
	
	var last = num - 1;
	
	if (critical) then obj.image_index = last;
	
	if (obj.image_index == last) {
		obj.scale = random_range(0.90, 1.20) - 0.5;
		obj.fadeout = true;
		obj.fadeoutSpeed = 0.05;
		
		var tilt = 5;
		obj.angle = 0;
		return;
	}
	
	obj.angle = irandom(360);
});

gravityApply = false;
lifetime = 17;
fadeout = false;
fadeoutSpeed = 0.05;

hsp += random_range(-0.10, 0.10);
vsp -= random(1.00);

scale = random_range(0.40, 0.70);

critical = false;

angleDir = choose(-1, 1);
