
function item_init(){
	
	globalvar ItemData; ItemData = ds_map_create();
	globalvar ITEM;
	
	ITEM = {
		
		getDefaultComponents: function(type) {
			switch(type) {
				case ITEM_TYPE.Blank:
					return {
						update : function(){},
					};
					
				case ITEM_TYPE.Armor:
					return {
						update : function(){},
						
					};
					
			}
		},
		
		register: function(itemID, type, name, sprite, components={}) {
			var item = {};
			item.type = type;
			item.name = name;
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
	
	
	ITEM.register(ITEM_ID.ScrapElectronics, ITEM_TYPE.Blank, "scrap electronics", sScrapElectronics_Item);
	TRANSLATION.add(ITEM_ID.ScrapElectronics)
		.set(LANGUAGE_ID.English, "scrap electronics")
		.set(LANGUAGE_ID.Brazilian, "resto de eletrônicos")
		.finalize();
	
	
	ITEM.register(ITEM_ID.Jetpack, ITEM_TYPE.Armor, "jetpack", -1, {
		update : function() {
			if (!instance_exists(Player)) return;
			
			with (Player) {
				
			}
		},
	});
	TRANSLATION.add(ITEM_ID.Jetpack)
		.set(LANGUAGE_ID.English, "jetpack")
		.set(LANGUAGE_ID.Brazilian, "mochila a jato")
		.finalize();
	
}

