
event_inherited();

spd = 0.25;
hasSeenPlayer = false;

tick = 0;

spriteStates.idle = sEndocadaver_Idle_Enemy;
spriteStates.stun = sEndocadaver_Idle_Enemy;
spriteStates.move = sEndocadaver_Move_Enemy;
spriteStates.attack = sEndocadaver_Attack_Enemy;

damage = 200;
projdamage = 5;

radius = 50;

setHp(50);

stunWhenHit = 23;

attacking = false;
attackingDistance = 8;
attackCooldown = 50;

ableToAttack = false;


// Particles when hit
onHitCallbacks.register(function(){
	var num = 3;
	var spr = sParticle_Bones;
	var dir = player_get_hdir();
	
	var pos = randvec2(x, y, sprite_width / 1.5);
	
	repeat (num) {
		var angle = irandom(360);
		
		var p = instance_create_depth(pos.x, pos.y, depth, Particle);
		p.sprite = spr;
		p.getRandomSprite = true;
		
		p.angle = angle;
		p.theta = random_range(0.05, 1.05) * -dir;
		
		p.scale = random_range(0.50, 1.11);
		
		p.gravityApply = true;
		p.gravityForce = 0.075;
		p.hsp = -dir * random_range(0.50, 1.25);
		p.vsp -= random_range(0.20, 0.80) * 3;
	}
});




