

var dialogueScale = 1.5;

handDustRange = 20;
handHeightCharge = 435;
handHeightChargeAmount = 0.25;
handChargeSpeed = 9;
handShakeValue = 0.35;


// Cutscene Start
cutsceneStart = cutscene_create();

cutscene_append(
	cutsceneStart,
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(1)
		.onStart(function(){
			if (!instance_exists(Player)) return;
			Player.halt();
		})
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.WaitFor)
		.waitFor(function(){
			if (!instance_exists(Player)) return;
			return Player.onGround;
		})
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger)
		.setMovePosition(undefined, 490, 0.75)
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(1 * 60)
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Textbox)
		.setDialogue([
			TRANSLATION.Get("cutscene_junkeeper_0"),
			TRANSLATION.Get("cutscene_junkeeper_1"),
			TRANSLATION.Get("cutscene_junkeeper_2"),
			TRANSLATION.Get("cutscene_junkeeper_3"),
			TRANSLATION.Get("cutscene_junkeeper_4"),
			TRANSLATION.Get("cutscene_junkeeper_5"),
		])
		.setDialogueVoice(snd_junkkeeper_voice, [0.20, 0.60])
		.setObject(Junkdigger_Head)
		.setPosition(Junkdigger_Head.x, Junkdigger_Head.y)
		.setOffset(0, -190)
		.onStart(function(){
			camera_focus(Junkdigger_Head);
			camera_set_zoom(1.25);
		})
		.onUpdate(function(){
			if (!instance_exists(Textbox)) return;
			
			// Change facial expression
			// This is a hardcoded mess but i don't give a single fuck
			// my textbox system is garbage so i have to check the dialogue index
			if (Textbox.index == 2) {
				Junkdigger_Head.changeFacialExpression(sBoss_Junkdigger_FE_sophisticated);
				
			} else if (Textbox.index == 5) {
				Junkdigger_Head.changeFacialExpression(sBoss_Junkdigger_FE_cringe);
				
			}
			
		})
		.onEnd(function(){
			Level.setBackgroundSong(snd_march_of_the_robots, true)
			camera_focus(Player);
			//camera_set_zoom(CAMERA_ZOOM_DEFAULT);
		})
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.leftHand)
		.setMovePosition(undefined, handHeightCharge, 2)
		.onUpdate(function(){
			var xx = handShakeValue;
			var hand = Junkdigger.leftHand;
			hand.x += random_range(-xx, xx);
			hand.depth = layer_get_depth(layer_get_id("Boss_Hand_Back"));
			
			var bg = layer_background_get_id("Background_Boss");
			var alpha = layer_background_get_alpha(bg);
			layer_background_alpha(bg, lerp(alpha, 0.66, 0.05));
			
		})
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.leftHand)
		.setMovePosition(undefined, JUNKKEEPER_HAND_POSITION, handChargeSpeed, handHeightChargeAmount)
		.onStart(function(){
			var hand = Junkdigger.leftHand;
			hand.depth = layer_get_depth(layer_get_id("Boss_Hand_Front"));
		})
		.onEnd(function(){
			camera_shake(3);
			var hand = Junkdigger.leftHand;
			hand.createJunkParticles(hand.x, hand.y, 10);
			create_dust_particles(hand.x, hand.y, handDustRange, 25);
		})
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(30)
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.rightHand)
		.setMovePosition(undefined, handHeightCharge, 2)
		.onUpdate(function(){
			var xx = handShakeValue;
			var hand = Junkdigger.rightHand;
			hand.x += random_range(-xx, xx);
			hand.depth = layer_get_depth(layer_get_id("Boss_Hand_Back"));
		})
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.rightHand)
		.setMovePosition(undefined, JUNKKEEPER_HAND_POSITION, handChargeSpeed, handHeightChargeAmount)
		.onStart(function(){
			var hand = Junkdigger.rightHand;
			hand.depth = layer_get_depth(layer_get_id("Boss_Hand_Front"));
		})
		.onEnd(function(){
			camera_shake(3);
			var hand = Junkdigger.rightHand;
			hand.createJunkParticles(hand.x, hand.y, 10);
			create_dust_particles(hand.x, hand.y, handDustRange, 25, 2);
		})
		.finalize(),
		
		CutsceneStep(CUTSCENE_EVENT.Sleep)
			.setTime(1 * 60)
			.onEnd(function(){
				Junkdigger.leftHand.state = JUNKEEPER_HAND_STATE.ChargingThrow;
				Junkdigger.rightHand.state = JUNKEEPER_HAND_STATE.ChargingThrow;
			})
			.finalize(),
);

// Cutscene No Hands :(
cutsceneNoHands = cutscene_create();

cutscene_append(
	cutsceneNoHands,
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.onStart(Player.halt)
		.setTime(2 * 60)
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Textbox)
		.setDialogue([
			TRANSLATION.Get("cutscene_junkeeper_nohands_0"),
			TRANSLATION.Get("cutscene_junkeeper_nohands_1"),
		])
		.setObject(Junkdigger_Head)
		.setPosition(Junkdigger_Head.x, Junkdigger_Head.y)
		.setOffset(0, -20)
		.onStart(function(){
			camera_focus(Junkdigger_Head);
			camera_set_zoom(0.95);
		})
		.onUpdate(function(){
			if (!instance_exists(Textbox)) return;
			
			if (Textbox.index == 1) {
				camera_set_zoom(1.15);
			}
			
		})
		.onEnd(function(){
			camera_set_zoom(1.15);
			camera_focus(Player);
			Junkdigger_Head.changeFacialExpression(sBoss_Junkdigger_FE_puto);
			Junkdigger_Head.defaultFacialExpression = sBoss_Junkdigger_FE_puto;
			//camera_set_zoom(CAMERA_ZOOM_DEFAULT);
			
			Junkdigger.gracePeriod = 60;
		})
		.finalize(),
);


// Death
cutsceneDeath = cutscene_create();
cutscene_append(
	cutsceneDeath,
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(30)
		.onStart(function(){
			instance_destroy(Junkdigger_Body);
			
			Player.halt();
		})
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.WaitFor)
		.waitFor(function(){
			if (!instance_exists(Junkdigger_Head)) return;
			return (Junkdigger_Head.y > room_height * 1.5);
		})
		.onUpdate(function(){
			if (!instance_exists(Junkdigger_Head)) return;
			
			Junkdigger_Head.vsp += Gravity;
			Junkdigger_Head.image_alpha += 0.7;
			Junkdigger_Head.x += 0.07;
			
			camera_shake(2, 3);
			create_explosion_particles(Junkdigger_Head.x, Junkdigger_Head.y, 50, 0.5);
		})
		.finalize(),
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(60)
		.finalize(),
);

cutsceneIndex = cutsceneStart;
