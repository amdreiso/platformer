
if (Level.isCutscene) return;

draw();

if (Debug.debug) {
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
}

draw_debug();
