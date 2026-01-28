
signalID = 0;
active = Level.signals.Has(signalID);

collision = instance_create_layer(x, y, "Collisions", Collision);
collision.image_xscale = sprite_width / 16;
collision.image_yscale = sprite_height / 16;

positionActive = new Vec2(x, y - sprite_height);
positionInactive = new Vec2(x, y);

// reply when signal is sent
Level.signalCallback.Register(function(){
	if (!Level.signals.Has(signalID)) return;
	active = !active;
});
