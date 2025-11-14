
function ToolSpells() constructor {
	self.list = [];
	
	static add = function(spellID) {
		array_push(self.list, spellID);
		
	}
	
	static apply = function(obj) {
		if (!instance_exists(obj)) return;
		
		// Loop through list of spells, run the attackApplyModifiers on the obj, and apply the effect IDs, all from SpellData
		for (var i = 0; i < array_length(self.list); i++) {
			var spellID = self.list[i];
			var spell = SPELL.get(spellID);
			var effectID = spell.effectID;
			
			if (effectID != -1) {
				// HARDCODE ALERT!!!!!! 5 * 60 SHOULD BE THE DEFAULT TIME THE EFFECT LASTS.
				effect_add(obj, effectID, 5 * 60);
			}
			
			spell.applyAttackModifiers(obj);
		}
	}
	
	static has = function(spellID) {
		for (var i = 0; i < array_length(self.list); i++) {
			if (self.list[i] == spellID) return true;
		}
		
		return false;
	}
}


function Tool(itemID) constructor {
	self.itemID = itemID;
	self.spell = new ToolSpells();
	
	static set = function(itemID) {
		self.itemID = itemID;
	}
	
	static get = function() {
		return ITEM.Get(self.itemID);
	}
	
	static getType = function() {
		return ITEM.GetType(self.itemID);
	}
}

function Armor(itemID) constructor {
	self.itemID = itemID;
	
	static set = function(itemID) {
		self.itemID = itemID;
	}
	
	static get = function() {
		return ITEM.Get(self.itemID);
	}
	
	static getDefense = function() {
		return ITEM.Get(self.itemID).components.defense;
	}
}
