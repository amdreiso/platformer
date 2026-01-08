

function item_init(){
	
	globalvar ITEM;
	
	//var defaultComponents = function() {
	//	var components = {
			
	//		// Default
	//		update : function(){},
	//		sprite : -1,
			
	//		// Armor
	//		defense : 1.00,
			
	//		// Sword
	//		damage : 1,
	//		attackSprite : sPlayer_Attack1,
			
	//		// Spell
	//		spellID : undefined,
			
	//	};
			
	//	return components;
	//};
	
	
	defaultComponents = {
		update : function(){},
		sprite : -1,
		icon : -1,
		canUseSpell : false,
	};
	
	var swordComponents = function(components={}) {
		var final = {};
		
		// Apply defaults
		struct_merge(final, defaultComponents);
		
		// Unique components
		var unique = {
			type : ITEM_TYPE.Sword,
			canUseSpell : true,
			damage : 1,
			attackSprite : sPlayer_Attack1,
		};
		
		// Apply new components
		struct_merge(final, unique);
		struct_merge(final, components);
		
		return final;
	}
	var spellComponents = function(components={}) {
		var final = {};
		
		// Apply defaults
		struct_merge(final, defaultComponents);
		
		// Unique components
		var unique = {
			spellID : undefined,
			type : ITEM_TYPE.Spell,
		};
		
		// Apply new components
		struct_merge(final, unique);
		struct_merge(final, components);
		
		return final;
	}
	var armorComponents = function(components={}) {
		var final = {};
		
		// Apply defaults
		struct_merge(final, defaultComponents);
		
		// Unique components
		var unique = {
			type : ITEM_TYPE.Armor,
			defense : 1,
		};
		
		// Apply new components
		struct_merge(final, unique);
		struct_merge(final, components);
		
		return final;
	}
	var moduleComponents = function(components={}) {
		var final = {};
		
		// Apply defaults
		struct_merge(final, defaultComponents);
		
		// Unique components
		var unique = {
			type : ITEM_TYPE.Module,
			icon : -1,
			use : function(){},
			update : function(){},
			draw : function(){},
		};
		
		// Apply new components
		struct_merge(final, unique);
		struct_merge(final, components);
		
		return final;
	}
	
	ITEM = new Registry();
	ITEM.SetDefaultComponents( defaultComponents );
	
	#region Blanks
	
	// Currency
	ITEM.Register(ITEM_ID.Gold, {
		sprite : sItem_Gold,
		type : ITEM_TYPE.Blank,
	});
	
	
	ITEM.Register(ITEM_ID.ScrapElectronics, {
		sprite : sItem_ScrapElectronics,
		type : ITEM_TYPE.Blank,
	});
	
	ITEM.Register(ITEM_ID.Dynamite, {
		sprite : sItem_TNT,
		type : ITEM_TYPE.Blank,
	});
	
	#endregion
	
	#region Spells
	
	ITEM.Register(ITEM_ID.FlameSpell, spellComponents({
		spellID : SPELL_ID.Flames,
	}));
	
	ITEM.Register(ITEM_ID.FreezeSpell, spellComponents({
		spellID: SPELL_ID.Freeze,
	}));
	
	ITEM.Register(ITEM_ID.PoisonSpell, spellComponents({
		spellID: SPELL_ID.Poison,
	}));
	
	ITEM.Register(ITEM_ID.KnockbackSpell, spellComponents({
		spellID: SPELL_ID.Knockback,
	}));
	
	ITEM.Register(ITEM_ID.StrengthSpell, spellComponents({
		spellID: SPELL_ID.Strength,
	}));
	
	#endregion
	
	#region Armor
	
	ITEM.Register(ITEM_ID.Jetpack, armorComponents());
	
	ITEM.Register(ITEM_ID.Armor, armorComponents({
		defense: 1.50,
	}));
	
	#endregion
	
	#region Swords
	
	ITEM.Register(ITEM_ID.BaseballBat, swordComponents({
		damage : 2,
		icon : sItem_BaseballBat,
	}));
	
	ITEM.Register(ITEM_ID.DevStick, swordComponents({
		damage : infinity,
		icon : sItem_DevStick,
	}));
	
	#endregion
	
	#region Modules
	
	ITEM.Register(ITEM_ID.HighJumpModule, moduleComponents({
		name : "High Jump Module",
		sprite : sModule_HighJump,
		icon : sModule_HighJump,
		
		use : function(obj){
			
		},
		
		update : function(){
			
		},
		
		draw : function(){
			
		},
		
	}));
	
	ITEM.Register(ITEM_ID.PortalCasterModule, moduleComponents({
		name : "Portal Caster Module",
		sprite : sModule_PortalCaster,
		icon : sModule_PortalCaster,
		
		use : function(obj){
			obj.modulePortalCasterPrompt = !obj.modulePortalCasterPrompt;
		},
		
		update : function(obj){
			
		},
		
		draw : function(obj){
			
			if (!obj.modulePortalCasterPrompt) return;
			
			// Choose prompt
			
			// Make portal
			if (Keymap.player.upPressed) {
				obj.modulePortalCasterPrompt = false;
				
				obj.modulePortalCasterPortal.roomID = room;
				obj.modulePortalCasterPortal.pos = new Vec2(obj.x, obj.y);
				
				// Remove previous portal
				Level.roomInstanceDestroy( PlayerPortal );
				
				// Create portal object
				var p = instance_create_layer(obj.x, obj.y, "Background_Instances", PlayerPortal);
				Level.roomInstanceAdd( new Instance(PlayerPortal, obj.x, obj.y, {
					depth : p.depth,
				}) );
			}
			
			// Go to portal
			if (Keymap.player.downPressed) {
				obj.modulePortalCasterPrompt = false;
					
				var portal = obj.modulePortalCasterPortal;
				if (room_exists(portal.roomID)) {
					if (room != portal.roomID) Level.goto( portal.roomID );
					
					obj.x = portal.pos.x;
					obj.y = portal.pos.y;
				}
			}
			
			if (Keymap.player.cancel) {
				obj.modulePortalCasterPrompt = false;
				// Do nothing
			}
				
			// Draw prompt
			var multiplier = 0.75;
			var xoff = 32 * multiplier, yoff = -48 * multiplier;
			var ydiv = 1.5;
			var bsize = 0.5;
			
			// Left option
			draw_sprite_ext(sPrompt_PortalCaster, 0, obj.x - xoff, obj.y + yoff, 1, 1, 0, c_white, 1);
			draw_key(KEY_INDICATOR.Up, new Vec2(obj.x - xoff * 1.25, obj.y + yoff / ydiv), bsize);
			
			// Right option
			var color1 = c_white;
			
			if (obj.modulePortalCasterPortal.roomID == -1) then color1 = c_dkgray;
			
			draw_sprite_ext(sPrompt_PortalCaster, 1, obj.x + xoff, obj.y + yoff, 1, 1, 0, color1, 1);
			draw_key(KEY_INDICATOR.Down, new Vec2(obj.x + xoff * 1.25, obj.y + yoff / ydiv), bsize);
			
		},
		
	}));
	
	#endregion
	
}

