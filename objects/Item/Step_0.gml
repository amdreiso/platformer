
x += hsp + knockback.x;
y += vsp + knockback.y;

if (applyGravity) {
	vsp += Gravity;
}

collision_set(Collision);
collision_set(Collision_Slope);
