
x += hsp + force.x;
y += vsp + force.y;

if (applyGravity) {
	vsp += Gravity;
}

collision_set(Collision);
collision_set(Collision_Slope);
