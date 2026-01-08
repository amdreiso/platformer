
y += vsp;
vsp += Gravity;

image_angle += angle;

if (instance_place(x, y, Collision)) {
	instance_destroy();
}


