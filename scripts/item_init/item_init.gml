
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
			return (ItemData[? itemID].type);
		},
		
	};
	
	ITEM.register(ITEM_ID.ScrapElectronics, ITEM_TYPE.Blank, "scrap electronics", -1);
	
}
