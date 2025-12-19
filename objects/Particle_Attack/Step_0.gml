
event_inherited();

interval_set(self, 5, function() {
	hsp += 0.05 * angleDir; 
	vsp -= 0.05;
	scale += 0.5;
	angle += 2;
});
