
function CutsceneStep(event) {
	cs = {};			// Cutscene Step
	
	cs.event = event;
	cs.object = undefined;
	cs.moveSpd = 1;
	cs.moveX = undefined;
	cs.moveY = undefined;
	cs.time = 0;
	cs.dialogue = [];
	cs.dialogueSound = -1;
	cs.dialoguePitch = 1;
	cs.offset = vec2(0, -20);
	
	cs.onStart			= function(){ };
	cs.onUpdate			= function(){ };
	cs.onEnd				= function(){ };
	cs.waitFor			= function(){ };
	
	
	// Functions
	methods = {};
	
	methods.waitFor = function(fn) {
		cs.waitFor = fn;
		return methods;
	};
	
	
	methods.setObject = function(obj) {
		cs.object = obj;
		return methods;
	};
	
	methods.setMovePosition = function(x, y, movespd) {
		cs.moveX = x;
		cs.moveY = y;
		cs.moveSpd = movespd;
		return methods;
	};
	
	methods.setTime = function(time) {
		cs.time = time;
		return methods;
	}
	
	methods.setDialogue = function(dialogue) {
		cs.dialogue = dialogue;
		return methods;
	}
	
	methods.setDialogueSound = function(sound) {
		cs.dialogueSound = sound;
		return methods;
	}
	
	methods.setPosition = function(x, y) {
		cs.pos = vec2(x, y);
		return methods;
	}
	
	methods.setDialoguePitch = function(pitch) {
		cs.dialoguePitch = pitch;
		return methods;
	}
	
	methods.setOffset = function(x, y) {
		cs.offset = vec2(x, y);
		return methods;
	}
	
	methods.onEnd = function(fn) {
		cs.onEnd = fn;
		return methods;
	}
	
	methods.onStart = function(fn) {
		cs.onStart = fn;
		return methods;
	}
	
	methods.onUpdate = function(fn) {
		cs.onUpdate = fn;
		return methods;
	}
	
	methods.finalize = function() {
		return cs;
	}
	
	return methods;
}