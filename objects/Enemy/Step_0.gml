
if (Sleep) return;

if (Player.busy) return;

movement();
collisions();
handleHealth();

children.ForEach(function(e){
	e.x = x;
	e.y = y;
});

effect_run(self, "update");
effect_apply();
