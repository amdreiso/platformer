
sprite = -1;

hitCooldown = 0;
hp = 3;

onDestroy = function() {};

hit = function(){
	hitCooldown = 2 * 60;
	hp --;
	if (hp <= 0) {
		instance_destroy();
	}
};

