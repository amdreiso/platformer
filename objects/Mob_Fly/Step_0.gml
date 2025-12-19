
event_inherited();

if (!instance_exists(Player) || busy) return;

var side = signabs(Player.image_xscale);
var xto = Player.x + (offset.x * side);

var dir = point_direction(
	x, y, 
	xto, 
	Player.y + offset.y
);

hsp = lengthdir_x(spd, dir);
vsp = lengthdir_y(spd, dir);

vsp += sin(current_time * flyTime) * flyAmplitude;

