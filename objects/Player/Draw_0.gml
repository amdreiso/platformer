
if (Level.isCutscene) return;

draw();

if (Debug.debug) {
	if (!is_undefined(lastPlaceStanding)) {
		draw_circle(lastPlaceStanding.x, lastPlaceStanding.y, 4, true);
	}
}

draw_debug();


// Upgrades
upgrade.draw(self);


// Effects
effect_run(self, "draw");

