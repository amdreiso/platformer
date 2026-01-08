
event_inherited();

damage = 40;
destroyOnPlayerContact = true;

vsp = 0;
vsp -= choose(1, 2, 3);

spriteStates = {
	idle: sItem_TNT,
	move: sItem_TNT,
}

angle = 1.77 * choose(-1, 1);

image_xscale = choose(-1, 1);


