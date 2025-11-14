
event_inherited();

var dialogueScale = 1.5;

handDustRange = 20;
handHeightCharge = 450;
handHeightChargeAmount = 0.25;
handChargeSpeed = 7;
handShakeValue = 0.35;

cutscene = [
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(1)
		.onStart(function(){
			if (!instance_exists(Player)) return;
			Player.hsp = 0;
			Player.vsp = 0;
			Player.knockback = new Vec2();
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
		.setMovePosition(undefined, 520, 0.75)
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Sleep)
		.setTime(1 * 60)
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Textbox)
		.setDialogue([
			TRANSLATION.get("cutscene_junkeeper_0"),
			TRANSLATION.get("cutscene_junkeeper_1"),
			TRANSLATION.get("cutscene_junkeeper_2"),
			TRANSLATION.get("cutscene_junkeeper_3"),
			TRANSLATION.get("cutscene_junkeeper_4"),
			TRANSLATION.get("cutscene_junkeeper_5"),
		])
		.setObject(Junkdigger_Head)
		.setPosition(Junkdigger_Head.x, Junkdigger_Head.y)
		.setOffset(0, -150)
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
				
				Junkdigger_Head.changeFacialExpression(sBoss_Junkdigger_FE_satisfaction);
				
			} else if (Textbox.index == 5) {
				
				Junkdigger_Head.changeFacialExpression(sBoss_Junkdigger_FE_cringe);
				
			}
			
		})
		.onEnd(function(){
			Level.setBackgroundSong(snd_boss1, true)
			camera_focus(Player);
			//camera_set_zoom(CAMERA_ZOOM_DEFAULT);
		})
		.finalize(),
	
	
	CutsceneStep(CUTSCENE_EVENT.Move)
		.setObject(Junkdigger.leftHand)
		.setMovePosition(undefined, handHeightCharge - 5, 2)
		.onUpdate(function(){
			var xx = handShakeValue;
			var hand = Junkdigger.leftHand;
			hand.x += random_range(-xx, xx);
			hand.depth = layer_get_depth(layer_get_id("Boss_Hand_Back"));
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
			create_dust_particles(hand.x, hand.y, handDustRange, 25);
		})
		.finalize(),
	
	
		
]
