
function PlayerModules() constructor {
	self.slots = array_create(3, -1);
	
	static Set = function(slotID, moduleID){
		self.slots[slotID] = moduleID;
		
		print($"Player Module: slot {slotID} : {TRANSLATION.Get("item_" + string(moduleID))}");
	}
	
	static Has = function(moduleID){
		for (var i = 0; i < array_length(self.slots); i++) {
			if (self.slots[i] == moduleID) {
				return true;
			}
		}
		return false;
	}
	
	static Push = function(moduleID){
		for (var i = 0; i < array_length(self.slots); i++) {
			if (self.slots[i] == -1) {
				self.slots[i] = moduleID;
				return true;
			}
		}
		return false;
	}
	
	static Get = function(slotID){
		return self.slots[slotID];
		
	}
	
	static Update = function(obj){
		
		var use = function(itemID, obj) {
			var item = ITEM.Get(itemID);
			if (item != undefined && ITEM.GetType(itemID) == ITEM_TYPE.Module) {
				print($"Player: Used Module {item.components.name}");
				item.components.use( obj );
			}
		}
		
		var slot0 = self.slots[0];
		if (Keymap.player.module0 && slot0 != -1) {
			use(slot0, obj);
		}
		
		var slot1 = self.slots[1];
		if (Keymap.player.module1 && slot1 != -1) {
			use(slot1, obj);
		}
		
		var slot2 = self.slots[2];
		if (Keymap.player.module2 && slot2 != -1) {
			use(slot2, obj);
		}
		
	}
	
	static Draw = function(obj) {
		for (var i = 0; i < array_length(self.slots); i++) {
			var itemID = self.slots[i];
			var item = ITEM.Get(itemID);
			
			if (item == undefined) break;
			if (ITEM.GetType(itemID) != ITEM_TYPE.Module) break;
			
			item.components.draw( obj );
			
		}
	}
	
}