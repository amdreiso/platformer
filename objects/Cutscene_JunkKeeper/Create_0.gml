
event_inherited();

var dialogueScale = 1.5;

cutscene = [
	
	CutsceneStep(CUTSCENE_EVENT.WaitFor)
		.waitFor(function(){
			if (!instance_exists(Player)) return;
			return Player.onGround;
		})
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger)
		.setMovePosition(undefined, 520, 0.5)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(2 * 60)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Textbox)
		.setDialogue([
			$"[scale=1.25][shake=1]YOU SHOULDN'T HAVE COME HERE![/shake][/scale]",
			$"[scale=1.25][shake=1]THIS JUNK IS ALL MINE!!![/shake][/scale]",
			$"[scale=0.55][shake=0.1]YOUR CIRCUITS WILL BE A GREAT ADDITION TO MY COLLECTION![/shake][/scale]",
			$"[scale=1.35][shake=0.2][color=red]BOOT YOURSELF![/color][/shake][/scale]",
		])
		.setObject(Junkdigger_Head)
		.setPosition(Junkdigger_Head.x, Junkdigger_Head.y)
		.setOffset(0, -150)
		.onStart(function(){
			camera_focus(Junkdigger_Head);
			camera_set_zoom(1.25);
		})
		.onEnd(function(){
			Level.setBackgroundSong(snd_boss1, true)
			camera_focus(Player);
			//camera_set_zoom(CAMERA_ZOOM_DEFAULT);
		})
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.leftHand)
		.setMovePosition(undefined, 480, 2)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.leftHand)
		.setMovePosition(undefined, JUNKKEEPER_HAND_POSITION, 5)
		.onEnd(function(){
			camera_shake(3);
		})
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(30)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.rightHand)
		.setMovePosition(undefined, 480, 2)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.rightHand)
		.setMovePosition(undefined, JUNKKEEPER_HAND_POSITION, 5)
		.onEnd(function(){
			camera_shake(3);
		})
		.finalize(),
	
	
		
]
