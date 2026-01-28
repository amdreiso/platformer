
event_inherited();

destroyOnPlayerAttack = true;

collisions.Register(function(){
	player_attack_check(function(){
		if (!destroyOnPlayerAttack) return;
		instance_destroy();
	}, false, true);
});
