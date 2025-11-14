function cutscene_init(){

}

function cutscene_create() {
	var cutscene = {
		step: 0,
		load: true,
		tick: 0,
		nodes: [],
		moveSpeed: 0,
	}
	
	return cutscene;
}

function cutscene_append(cutscene) {
	if (!is_struct(cutscene)) return;
	if (!variable_struct_exists(cutscene, "nodes")) return;
	if (!is_array(cutscene.nodes)) return;
	
	
	for (var i = 1; i < argument_count; i++) {
		array_push(cutscene.nodes, argument[i]);
	}
}

function cutscene_reset(cutscene) {
	cutscene.moveSpeed = 0;
}

function cutscene_next(cutscene, onEnd=function(){}, loop = true) {
	if (cutscene.step < array_length(cutscene.nodes) - 1) {
		
		cutscene_reset(cutscene);
		
		cutscene.step ++;
		cutscene.load = true;
		
		onEnd();
		
	} else {
		if (loop)	then cutscene.step = 0;
	}
}

function cutscene_play(cutscene, loop = true) {
	var step = cutscene.step;
	var nodes = cutscene.nodes;
	var tick = cutscene.tick;
	var load = cutscene.load;
	var moveSpeed = cutscene.moveSpeed;
	
	var currentStep = nodes[step];
	
	switch (currentStep.event) {
		case CUTSCENE_EVENT.Move:
			
			if (load) {
				currentStep.onStart();
				load = false;
			}
			
			cutscene.moveSpeed = lerp(cutscene.moveSpeed, currentStep.moveSpd, currentStep.moveAmt);
			
			var spd = moveSpeed;
			
			if (currentStep.moveX != undefined) {
				var hsp = sign(currentStep.moveX - currentStep.object.x);
				
				currentStep.object.hsp = hsp * spd;
				
				var tolerance = spd;
				if (currentStep.object.x > currentStep.moveX - tolerance && currentStep.object.x < currentStep.moveX + tolerance) {
					currentStep.object.hsp = 0;
					cutscene_next(cutscene, currentStep.onEnd(), loop);
				}
			}
			
			if (currentStep.moveY != undefined) {
				var vsp = sign(currentStep.moveY - currentStep.object.y);
				
				currentStep.object.vsp = vsp * spd;
				
				var tolerance = spd;
				if (currentStep.object.y > currentStep.moveY - tolerance && currentStep.object.y < currentStep.moveY + tolerance) {
					currentStep.object.vsp = 0;
					cutscene_next(cutscene, currentStep.onEnd(), loop);
				}
			}
			
			currentStep.onUpdate();
			
			break;
			
		case CUTSCENE_EVENT.Textbox:
		
			if (load) {
				currentStep.onStart();
				load = false;
			}
			
			if (!instance_exists(Textbox)) {
				var tb = instance_create_depth(currentStep.pos.x + currentStep.offset.x, currentStep.pos.y + currentStep.offset.y, -99999, Textbox);
				
				_nodes = nodes;
				_step = step;
				_onEnd = currentStep.onEnd;
				_cutscene = cutscene;
				_loop = loop;
				
				tb.dialogue = currentStep.dialogue;
				tb.sound = currentStep.dialogueSound;
				tb.pitch = currentStep.dialoguePitch;
				tb.dialogueEnd = function() {
					if (_step < array_length(_nodes) - 1) return;
					cutscene_next(_cutscene, _onEnd(), _loop);
				};
			}
			
			currentStep.onUpdate();
			
			break;
		
		case CUTSCENE_EVENT.Sleep:
			
			if (load) {
				currentStep.onStart();
				load = false;
			}
			
			cutscene.tick ++;
			Level.screenlog(tick);
			
			if (tick >= currentStep.time) {
				cutscene_next(cutscene, currentStep.onEnd(), loop);
				cutscene.tick = 0;
			}
			
			currentStep.onUpdate();
			
			break;
		
		case CUTSCENE_EVENT.WaitFor:
			
			if (load) {
				currentStep.onStart();
				load = true;
			}
			
			if (currentStep.waitFor()) {
				cutscene_next(cutscene, currentStep.onEnd(), loop);
			}
			
			currentStep.onUpdate();
			
			break;
	}
	
}




