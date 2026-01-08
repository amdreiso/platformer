
y += vsp;
vsp += Gravity / 2;

image_angle += angle;

if (instance_place(x, y, Collision)) {
	instance_destroy();
}
