
function item_init(){
	
	globalvar ItemData; ItemData = ds_map_create();
	globalvar ITEM;
	
	ITEM = {
		
		register: function(itemID, type, name, sprite) {
			var item = {};
			item.type = type;
			item.name = name;
			item.sprite = sprite;
			
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
	
}

