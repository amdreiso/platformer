
if (Sleep) return;

if (Player.busy) return;

movement();
collisions();
handleHealth();

effect_run(self, "update");
effect_apply();
