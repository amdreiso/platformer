
//onLanguageReset = function() {
	cutscene = [
		CutsceneStep(CUTSCENE_EVENT.Textbox)
			.setPosition(400, 200)
			.setDialogue([
				//"[scale=2.5][italic][speed=10]I know you are not cognitive[/speed][/italic][/scale]"
				TRANSLATION.Get("cutscene_beggining_0")
			])
			.finalize(),
	
		CutsceneStep(CUTSCENE_EVENT.Sleep)
			.setTime(1 * 60)
			.finalize(),
	
		CutsceneStep(CUTSCENE_EVENT.Textbox)
			.setPosition(900, 300)
			.setDialogue([
				TRANSLATION.Get("cutscene_beggining_1"),
				TRANSLATION.Get("cutscene_beggining_2"),
			])
			.finalize(),
	
		CutsceneStep(CUTSCENE_EVENT.Textbox)
			.setPosition(400, 450)
			.setDialogue([
				TRANSLATION.Get("cutscene_beggining_3"),
			])
			.finalize(),
		
		CutsceneStep(CUTSCENE_EVENT.Sleep)
			.setTime(1 * 60)
			.finalize(),
		
		CutsceneStep(CUTSCENE_EVENT.Textbox)
			.setPosition(400, 450)
			.setDialogue([
				TRANSLATION.Get("cutscene_beggining_4"),
				TRANSLATION.Get("cutscene_beggining_5"),
			])
			.finalize(),
		
		CutsceneStep(CUTSCENE_EVENT.Sleep)
			.setTime(2.5 * 60)
			.finalize(),
			
		CutsceneStep(CUTSCENE_EVENT.Textbox)
			.setPosition(700, 550)
			.setDialogue([
				TRANSLATION.Get("cutscene_beggining_6"),
			])
			.finalize(),
	];
//}
