
event_inherited();

x += hsp;
y += vsp;

vsp += Gravity / 2;

var spd = 2;

angle += spd * GameSpeed * sign(hsp);

var hitSomething = (place_meeting(x, y + 1, Collision))

if (hitSomething && vsp > 0) {
	vsp -= vsp * 1.4;
	hsp = hsp / 1.05;
	used = true;
}

lifetime = max(0, lifetime - GameSpeed);
if (lifetime == 0) instance_destroy();
