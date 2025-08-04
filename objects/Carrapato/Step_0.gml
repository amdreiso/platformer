
event_inherited();

var currentPathPoint = path[pathIndex];

var xx = currentPathPoint.x;
var yy = currentPathPoint.y;

if (xx != undefined) {
	var pointHsp = sign(xx - x);
				
	hsp = pointHsp * spd;
				
	var tolerance = spd;
	if (x > xx - tolerance && x < xx + tolerance) {
		hsp = 0;
		pathNext();
	}
}
