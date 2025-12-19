
event_inherited();

setSprite( sNPC_Mig_Idle, sNPC_Mig_Move, sNPC_Mig_Idle );
setGravity( true );
setCollisions( Collision );

spd = 0.5;


// Walking back and forth
var len = 32;
cutscene_append(
	cutscene,
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(self)
		.setMovePosition(x - len, undefined, spd)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(self)
		.setMovePosition(x + len, undefined, spd)
		.finalize(),
);