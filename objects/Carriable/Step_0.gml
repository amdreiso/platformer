
onPlayer = (place_meeting(x, y, Player));

x += hsp + knockback.x;
y += vsp + knockback.y;

knockback_apply();

vsp += Gravity;
hsp = lerp(hsp, 0, 0.05);

collision_set(Collision);
collision_set(Collision_Slope);
collision_set(Collision_JumpThrough);
