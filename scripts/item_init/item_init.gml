
function item_init(){
	
	globalvar ItemData; ItemData = ds_map_create();
	globalvar ITEM;
	
	ITEM = {
		
		getDefaultComponents: function(type) {
			var components = {
				update: function(){},
			};
			
			var newComponents = {};
			
			
			switch(type) {
				case ITEM_TYPE.Blank:
					
					break;
					
				case ITEM_TYPE.Armor:
					
					break;
					
				case ITEM_TYPE.Sword:
					newComponents = {
						damage : 1,
						spells : [],
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
		},
		
		register: function(itemID, type, sprite, components={}) {
			var item = {};
			item.type = type;
			item.name = "unused item name, switch to TranslationData";
			item.sprite = sprite;
			
			item.components = ITEM.getDefaultComponents(type);
			
			struct_merge(item.components, components);
			
			ItemData[? itemID] = item;
		},
		
		get: function(itemID) {
			return (ItemData[? itemID] ?? undefined);
		},
		
		getType: function(itemID) {
			return (ItemData[? itemID].type ?? undefined);
		},
		
	};
	
	
	ITEM.register(ITEM_ID.ScrapElectronics, ITEM_TYPE.Blank, sScrapElectronics_Item);
	
	ITEM.register(ITEM_ID.Jetpack, ITEM_TYPE.Armor, -1, {
	});
	
	
	
	ITEM.register(ITEM_ID.BaseballBat, ITEM_TYPE.Sword, -1, {
		damage: 8,
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

