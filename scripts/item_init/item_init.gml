

function item_init(){
	
	globalvar ItemData; ItemData = ds_map_create();
	globalvar ITEM;
	
	var defaultComponents = function(type) {
		var components = {
			update: function(){},
			sprite: -1,
		};
			
		var newComponents = {};
			
		switch(type) {
			case ITEM_TYPE.Blank:
				break;
					
			case ITEM_TYPE.Armor:
				newComponents = {
					defense : 1.25,					// 25% defense example
				}
				break;
					
			case ITEM_TYPE.Sword:
				newComponents = {
					damage : 1,
					attackSprite : sPlayer_Attack1,
						
				};
					
				break;
				
			case ITEM_TYPE.Spell:
				newComponents = {
					spellID: undefined,
						
				};
					
				break;
		}
			
		struct_merge(components, newComponents);
		return components;
	};
	
	ITEM = new Registry();
	ITEM.SetDefaultComponents(defaultComponents);
	
	print(json_stringify(ITEM.defaultComponents));
	
	// Blanks
	ITEM.Register(ITEM_ID.ScrapElectronics, {
		type: ITEM_TYPE.Blank,
	});
	
	
	// Spells
	ITEM.Register(ITEM_ID.FlameSpell, {
		type: ITEM_TYPE.Spell,
		spellID: SPELL_ID.Flames,
	});
	
	ITEM.Register(ITEM_ID.FreezeSpell, {
		type: ITEM_TYPE.Spell,
		spellID: SPELL_ID.Freeze,
	});
	
	ITEM.Register(ITEM_ID.PoisonSpell, {
		type: ITEM_TYPE.Spell,
		spellID: SPELL_ID.Poison,
	});
	
	ITEM.Register(ITEM_ID.KnockbackSpell, {
		type: ITEM_TYPE.Spell,
		spellID: SPELL_ID.Knockback,
	});
	
	ITEM.Register(ITEM_ID.StrengthSpell, {
		type: ITEM_TYPE.Spell,
		spellID: SPELL_ID.Strength,
	});
	
	
	// Armor
	ITEM.Register(ITEM_ID.Jetpack, {
		type: ITEM_TYPE.Armor,
	});
	
	ITEM.Register(ITEM_ID.Armor, {
		type: ITEM_TYPE.Armor,
		defense: 1.50,
	});
	
	
	// Swords
	ITEM.Register(ITEM_ID.BaseballBat, {
		type: ITEM_TYPE.Sword,
		damage: 8,
		
		sprite: sItem_BaseballBat,
	});
	
	ITEM.Register(ITEM_ID.DevStick, {
		type: ITEM_TYPE.Sword,
		damage: infinity,
		
		sprite: sItem_DevStick,
	});
	
	
}

