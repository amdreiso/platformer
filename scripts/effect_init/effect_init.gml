function effect_init(){
	
	globalvar EffectData; EffectData = ds_map_create();
	globalvar EFFECT;
	
	EFFECT = {
		register : function(effectID, load = function(){}, update = function(){}, draw = function(){}, transferableByContact = false) {
			var e = {};
			e.load = load;
			e.update = update;
			e.draw = draw;
			
			e.transferableByContact = transferableByContact;
			
			EffectData[? effectID] = e;
		},
		
		get : function(effectID) {
			return (EffectData[? effectID] ?? undefined);
		},
	}
	
	#region BURNING
	
	EFFECT.register(
		EFFECT_ID.Burning,
		function(obj) {
			if (!instance_exists(obj)) return;
			
			effect_remove(obj, EFFECT_ID.Frozen);
		},
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			// for every second that passes, the player takes damage
			static time = 0;
			var damage = 15;
			
			time += GameSpeed;
			
			if (time > 60) {
				time = 0;
				
				// Only take damage if function hit exists
				if (variable_instance_exists(obj, "hit")) {
					obj.hit(damage, 1, false, false);
				}
			}
		},
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			var spr			= obj.sprite_index;
			var index		= obj.image_index;
			var xscale	= obj.image_xscale;
			var yscale	= obj.image_yscale;
			var angle		= obj.angle;
			
			if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);
			
			gpu_set_fog(true, c_orange, 0, 1);
			
			draw_sprite_ext(spr, index, obj.x, obj.y, xscale, yscale, angle, c_white, random_range(0.44, 0.87));
			
			gpu_set_fog(false, c_red, 0, 1);
			
			if (surface_exists(SurfaceHandler.surface)) surface_reset_target();
			
			
			// particles
			static time = 0;
			time += GameSpeed;
			if (floor(time) % 10 == true) {
				var num = irandom_range(1, 2);
				repeat (num) {
					if (!instance_exists(obj)) break;
					
					var pos = randvec2(obj.x, obj.y, obj.sprite_width / 2);
					var p = instance_create_depth(pos.x, pos.y, obj.depth - 100, Particle);
					
					var angleshift = 30;
					
					if (instance_exists(p)) {
						p.sprite = sParticle_Flames;
						p.getRandomSprite = true;
						p.lifetime = irandom_range(3, 6) * 60;
						p.gravityApply = false;
						p.color = choose(c_white, c_ltgray);
						p.hsp = random_range(-0.05, 0.05);
						p.vsp = random_range(-0.01, -0.10);
						p.angle = irandom_range(-angleshift, angleshift);
						p.scale = random_range(0.50, 1.25);
					}
				}
			}
			
		},
		true			/// Transferable
	);
	
	#endregion
	
	#region FREEZE
	
	EFFECT.register(
		EFFECT_ID.Frozen,
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			effect_remove(obj, EFFECT_ID.Burning);
		},
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			obj.hsp = obj.hsp / 2;
			
		},
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			var spr			= obj.sprite_index;
			var index		= obj.image_index;
			var xscale	= obj.image_xscale;
			var yscale	= obj.image_yscale;
			var angle		= obj.angle;
			
			if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);
			
			gpu_set_fog(true, c_aqua, 0, 1);
			
			draw_sprite_ext(spr, index, obj.x, obj.y, xscale, yscale, angle, c_white, random_range(0.44, 0.77));
			
			gpu_set_fog(false, c_red, 0, 1);
			
			if (surface_exists(SurfaceHandler.surface)) surface_reset_target();
			
			
			// particles
			static time = 0;
			time += GameSpeed;
			
			if (floor(time) % 10 == true) {
				var num = irandom_range(1, 2);
				repeat (num) {
					var pos = randvec2(obj.x, obj.y, obj.sprite_width / 2);
					var p = instance_create_depth(pos.x, pos.y, obj.depth - 100, Particle);
					
					var angleshift = 20;
					
					p.sprite = sParticle_Ice;
					p.getRandomSprite = true;
					p.lifetime = irandom_range(3, 6) * 60;
					p.gravityApply = false;
					p.color = choose(c_white, c_ltgray);
					p.hsp = random_range(-0.05, 0.05);
					p.vsp = random_range(-0.01, -0.10);
					p.angle = irandom_range(-angleshift, angleshift);
					p.scale = random_range(0.50, 1.25);
				}
			}
		},
	);
	
	#endregion
	
	#region POISON
	
	EFFECT.register(
		EFFECT_ID.Poison,
		function(obj) {
			if (!instance_exists(obj)) return;
		},
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			// for every second that passes, the player takes damage
			static time = 0;
			var damage = 5;
			
			time += GameSpeed;
			
			if (time > 60) {
				time = 0;
				
				// Only take damage if function hit exists
				if (variable_instance_exists(obj, "hit")) { 
					obj.hit(damage, 1, false, false);
				}
			}
		},
		
		function(obj) {
			if (!instance_exists(obj)) return;
			
			var spr			= obj.sprite_index;
			var index		= obj.image_index;
			var xscale	= obj.image_xscale;
			var yscale	= obj.image_yscale;
			var angle		= obj.angle;
			
			if (surface_exists(SurfaceHandler.surface)) surface_set_target(SurfaceHandler.surface);
			
			gpu_set_fog(true, c_lime, 0, 1);
			
			draw_sprite_ext(spr, index, obj.x, obj.y, xscale, yscale, angle, c_white, random_range(0.44, 0.77));
			
			gpu_set_fog(false, c_red, 0, 1);
			
			if (surface_exists(SurfaceHandler.surface)) surface_reset_target();
			
			
			// particles
			static time = 0;
			time += GameSpeed;
			if (floor(time) % 10 == true) {
				var num = irandom_range(1, 2);
				repeat (num) {
					if (!instance_exists(obj)) break;
					
					var pos = randvec2(obj.x, obj.y, obj.sprite_width / 2);
					var p = instance_create_depth(pos.x, pos.y, obj.depth - 100, Particle_Poison);
					
					var angleshift = 30;
					
					if (instance_exists(p)) {
						
						p.gravityApply = false;
						p.color = choose(c_white, c_ltgray);
						p.angle = irandom_range(-angleshift, angleshift);
						p.scale = random_range(0.325, 1.25);
						
					}
				}
			}
			
		},
		true			/// transferable By Contact
	);
	
	#endregion
	
}


function Effect(effectID, time) constructor {
	self.effectID = effectID;
	self.time = time;
	self.timeDefault = time;
}


function effect_add(obj, effectID, time) {
	if (!variable_instance_exists(obj, "effects")) return;
	
	with (obj) {
		var effect = new Effect(effectID, time);
		var found = false;
		
		for (var i = 0; i < array_length(effects); i++) {
			if (effects[i].effectID == effectID) {
				found = true;
				effects[i].time = effects[i].timeDefault;
			}
		}
		
		if (!found) then array_push(effects, effect);
		
		EFFECT.get(effectID).load(self);
	}
}


function effect_apply() {
	if (!variable_instance_exists(self, "effects")) return;
	
	for (var i = 0; i < array_length(effects); i++) {
		var e = effects[i];
		e.time = max(0, e.time - GameSpeed);
		
		if (e.time == 0) {
			array_delete(effects, i, 1);
		}
	}
}


function effect_run(obj, event) {
	if (!variable_instance_exists(self, "effects")) return;
	
	for (var i = 0; i < array_length(effects); i++) {
		var e = effects[i];
		var effectID = e.effectID;
		var effect = EFFECT.get(effectID);
		
		if (variable_struct_exists(effect, event)) {
			var scr = variable_struct_get(effect, event);
			if (is_callable(scr)) {
				scr(obj);
			}
		}
	}
}


function effect_transfer(effectList, obj) {
	if (!instance_exists(obj)) return;
	
	for (var i = 0; i < array_length(effectList); i++) {
		var e = effectList[i];
		effect_add(obj, e.effectID, e.timeDefault);
	}
}


function effect_remove(obj, effectID) {
	for (var i = 0; i < array_length(obj.effects); i++) {
		if (obj.effects[i].effectID == effectID) {
			array_delete(obj.effects, i, 1);
		}
	}
}


function effect_has(obj, effectID) {
	for (var i = 0; i < array_length(obj.effects); i++) {
		if (obj.effects[i].effectID == effectID) return true;
	}
	return false;
}



