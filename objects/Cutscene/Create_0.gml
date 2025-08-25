

onLanguageReset = function(){};

cutscene = [
	
	//// Spawn textbox
	//CutsceneStep(CUTSCENE_EVENT.Textbox)
	//	.setObject(Player)
	//	.setDialogue([
	//		"[color=red][scale=1.11][shake=0.7]wow[/shake][/scale] that's a textbox[/color]",
	//		"[color=3333ff]how cool[/color]",
	//	])
	//	.setDialogueSound(snd_textbox1)
	//	.setDialoguePitch(1)
	//	.setOffset(0, -20)
	//	.onStart(function(){
	//		camera_set_zoom(0.66);
	//	})
	//	.onEnd(function(){
	//		camera_set_zoom(CAMERA_ZOOM_DEFAULT);
	//	})
	//	.finalize(),
		
	//// Move Player to 420
	//CutsceneStep(CUTSCENE_EVENT.Move)
	//	.setObject(Player)
	//	.setMovePosition(420, undefined)
	//	.finalize(),
		
	//// Move Player back to 380
	//CutsceneStep(CUTSCENE_EVENT.Move)
	//	.setObject(Player)
	//	.setMovePosition(380, undefined)
	//	.finalize(),
		
	//// turn player to the right
	//CutsceneStep(CUTSCENE_EVENT.Move)
	//	.setObject(Player)
	//	.setMovePosition(385, undefined)
	//	.finalize(),
	
	//// Wait 2 seconds
	//CutsceneStep(CUTSCENE_EVENT.Sleep)
	//	.setTime(120)
	//	.onEnd(function(){
	//		QuestHandler.add("go fuck yourself", function(){ return false });
	//	})
	//	.finalize(),
	
	//// turn player to the right
	//CutsceneStep(CUTSCENE_EVENT.Move)
	//	.setObject(NPC_Robot1)
	//	.setMovePosition(450, undefined)
	//	.finalize(),
	
	//// Spawn textbox
	//CutsceneStep(CUTSCENE_EVENT.Textbox)
	//	.setObject(NPC_Robot1)
	//	.setDialogue([
	//		"[speed=5]you saw [speed=20][shake=0.77][scale=1.22][italic]NOTHING!!![/italic][/scale][/shake][/speed][/speed]",
	//	])
	//	.setOffset(0, -20)
	//	.onStart(function(){
	//		camera_set_zoom(0.66);
	//		camera_focus(NPC_Robot1);
	//	})
	//	.onEnd(function(){
	//		camera_set_zoom(CAMERA_ZOOM_DEFAULT);
	//		camera_focus(Player);
	//	})
	//	.finalize(),
	
	//// turn player to the right
	//CutsceneStep(CUTSCENE_EVENT.Move)
	//	.setObject(NPC_Robot1)
	//	.setMovePosition(750, undefined)
	//	.finalize(),
];

step = 0;
load = true;
tick = 0;

next = function(onEnd=function(){}) {
	if (step < array_length(cutscene)-1) {
		
		step ++;
		load = true;
		
		onEnd();
		
	} else {
		instance_destroy();
	}
}

play = function() {
	var c = cutscene[step];
	
	switch (c.event) {
		case CUTSCENE_EVENT.Move:
			
			if (load) {
				c.onStart();
				load = false;
			}
			
			var spd = c.moveSpd;
			
			if (c.moveX != undefined) {
				var hsp = sign(c.moveX - c.object.x);
				
				c.object.hsp = hsp * spd;
				
				var tolerance = spd;
				if (c.object.x > c.moveX - tolerance && c.object.x < c.moveX + tolerance) {
					c.object.hsp = 0;
					next(c.onEnd());
				}
			}
			
			if (c.moveY != undefined) {
				var vsp = sign(c.moveY - c.object.y);
				
				c.object.vsp = vsp * spd;
				
				var tolerance = spd;
				if (c.object.y > c.moveY - tolerance && c.object.y < c.moveY + tolerance) {
					c.object.vsp = 0;
					next(c.onEnd());
				}
			}
			
			c.onUpdate();
			
			break;
			
		case CUTSCENE_EVENT.Textbox:
		
			if (load) {
				c.onStart();
				load = false;
			}
			
			if (!instance_exists(Textbox)) {
				var tb = instance_create_depth(c.pos.x + c.offset.x, c.pos.y + c.offset.y, -99999, Textbox);
				
				_onEnd = c.onEnd;
				
				tb.dialogue = c.dialogue;
				tb.sound = c.dialogueSound;
				tb.pitch = c.dialoguePitch;
				tb.dialogueEnd = function() {
					if (!instance_exists(Cutscene)) return;
					Cutscene.next(_onEnd());
				};
			}
			
			c.onUpdate();
			
			break;
		
		case CUTSCENE_EVENT.Sleep:
			
			if (load) {
				c.onStart();
				load = false;
			}
			
			tick ++;
			
			if (tick >= c.time) {
				next(c.onEnd());
			}
			
			c.onUpdate();
			
			break;
		
		case CUTSCENE_EVENT.WaitFor:
			
			if (load) {
				c.onStart();
				load = true;
			}
			
			if (c.waitFor()) {
				next(c.onEnd());
			}
			
			c.onUpdate();
			
			break;
	}
	
}

add = function(step) {
	for (var i = 0; i < argument_count; i++) {
		array_push(cutscene, argument[i]);
	}
}






