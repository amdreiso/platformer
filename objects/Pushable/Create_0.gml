
children = new Children();

var collision = instance_create_layer(x, y, "Collisions", Collision);
children.Append(collision);

hsp = 0;
vsp = 0;
knockback = new Vec2();

sprite = sMetalBox;
