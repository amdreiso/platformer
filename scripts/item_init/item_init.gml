
function item_init(){
	
	globalvar ItemData; ItemData = ds_map_create();
	globalvar ITEM;
	
	var defaultComponents = function(type) {
		var components = {
			update: function(){},
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
	
	
	ITEM.Register(ITEM_ID.ScrapElectronics, {
		type: ITEM_TYPE.Blank,
	});
	
	
	ITEM.register(ITEM_ID.ScrapElectronics, ITEM_TYPE.Blank, sScrapElectronics_Item);
	
	ITEM.register(ITEM_ID.Jetpack, ITEM_TYPE.Armor, -1, {
	});
	
	
	ITEM.register(ITEM_ID.BaseballBat, ITEM_TYPE.Sword, sItem_BaseballBat, {
		damage: 8,
	});
	
	ITEM.register(ITEM_ID.DevStick, ITEM_TYPE.Sword, sItem_DevStick, {
		damage: infinity,
	});
	
	ITEM.register(ITEM_ID.Armor, ITEM_TYPE.Armor, -1, {
		defense : 1.50,
	});
	
	
	#region Spells
	
	ITEM.register(ITEM_ID.FlameSpell, ITEM_TYPE.Spell, -1, {
		spellID: SPELL_ID.Flames,
	});
	
	ITEM.register(ITEM_ID.FreezeSpell, ITEM_TYPE.Spell, -1, {
		spellID: SPELL_ID.Freeze,
	});
	
	ITEM.register(ITEM_ID.KnockbackSpell, ITEM_TYPE.Spell, -1, {
		spellID: SPELL_ID.Knockback,
	});
	
	ITEM.register(ITEM_ID.StrengthSpell, ITEM_TYPE.Spell, -1, {
		spellID: SPELL_ID.Strength,
	});
	
	#endregion
	
}

