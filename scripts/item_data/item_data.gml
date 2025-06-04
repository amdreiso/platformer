
function item_data() {
	globalvar ItemData;
	globalvar ITEMS;
	ItemData = ds_map_create();
}


function item_get_default_components(type) {
	switch (type) {
		case ITEM_TYPE.Blank:
			return {};
		
		case ITEM_TYPE.Armor:
			return {
				applyArmor: function(){},
			};
	}
}

ITEMS = {
	register: function(itemID, type, name, sprite, components = {}, rarity = ITEM_RARITY.Common) {
		var item = {};
	
		item.name = name;
		item.type = type;
		item.sprite = sprite;
		item.rarity = rarity;
		item.components = item_get_default_components(type);
	
		struct_merge(item.components, components);
	
		ItemData[? itemID] = item;
	}
}


function item_get(itemID) {
	if (!ds_map_exists(ItemData, itemID)) return;
	return ItemData[? itemID];
}

function item_init() {
	
	ITEMS.register(ITEM_ID.RoseTintedGlasses, ITEM_TYPE.Armor, "rose-tinted glasses", sRoseTintedGlasses_Item, {
		applyArmor: function(){
			// Make world pink
		}
	});
	
	ITEMS.register(ITEM_ID.ScrapElectronics, ITEM_TYPE.Blank, "scrap electronics", sScrapElectronics_Item, {});
	
}


