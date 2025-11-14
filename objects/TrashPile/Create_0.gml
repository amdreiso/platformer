
hsp = 0;
vsp = 0;

states = {};

var spd = 3;

states.idle = cutscene_create();
cutscene_append(
	states.idle, 
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(TrashPile)
		.setMovePosition(150, undefined, spd, 0.1)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(120)
		.finalize(),
		
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(TrashPile)
		.setMovePosition(250, undefined, spd, 0.1)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(120)
		.finalize(),
);

currentState = states.idle;


