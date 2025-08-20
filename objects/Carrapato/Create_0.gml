
event_inherited();

setHp(15);

meleeDamage = 5;

lightAlpha = 0.25;
lightColor = c_red;

weaponSprite = -1;

spriteStates = {
	idle: sCarrapato_Idle,
	move: sCarrapato,
}

path = [];
pathIndex = 0;
pathNext = function() {
	print($"Carrapato reached point: {pathIndex}");
	
	if (pathIndex < array_length(path)-1) {
		pathIndex ++;
	} else {
		pathIndex = 0;
	}
}
pathAdd = function(x, y) {
	array_push(path, vec2(x, y));
}
