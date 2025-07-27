
if (CurrentChapter.cave_entrance.cutscene_0.played) {
	instance_destroy();
}

trigger = function() {
	instance_create_depth(0, 0, depth, Cutscene);
	CurrentChapter.cave_entrance.cutscene_0.played = true;
	
	STORY.save();
}
