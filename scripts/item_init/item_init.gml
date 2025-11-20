

function item_init(){
	
	globalvar ItemData; ItemData = ds_map_create();
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
		sprite: -1,
		canUseSpell: false,
	};
	
	var swordComponents = function(components={}) {
		var final = {};
		
		// Apply defaults
		struct_merge(final, defaultComponents);
		
		// Unique components
		var unique = {
			type : ITEM_TYPE.Sword,
			canUseSpell : true,
			damage: 1,
		};
		
		// Apply new components
		struct_merge(final, unique);
		
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
		
		return final;
	}
	
	
	ITEM = new Registry();
	ITEM.SetDefaultComponents( defaultComponents );
	
	
	#region Blanks
	
	ITEM.Register(ITEM_ID.ScrapElectronics);
	
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
		damage: 2,
		sprite: sItem_BaseballBat,
	}));
	
	ITEM.Register(ITEM_ID.DevStick, swordComponents({
		damage: infinity,
		sprite: sItem_DevStick,
	}));
	
	#endregion
	
}

