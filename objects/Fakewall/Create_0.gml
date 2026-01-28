
sprite = -1;
breakingSound = snd_fakewall_stone;

hitCooldown = 0;
hp = 3;

onDestroy = function() {};

hit = function(){
	hitCooldown = 2 * 60;
	hp --;
	if (hp <= 0) {
		instance_destroy();
	} else {
		camera_shake(2);
	}
};

surface = -1;
