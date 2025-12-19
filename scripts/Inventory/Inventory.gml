function InventorySlot(itemID) constructor {
	self.itemID = itemID;
}

function Inventory(w = 5, h = 5) constructor {

	// Content
	self.content = [];
	self.slotIndex = 0;
	
	enum INVENTORY_SECTION {
		Items,
		Equipment,
	}
	
	self.section = INVENTORY_SECTION.Items;
	self.itemSelected = -1;
	
	// Equipment, armor, swords, etc
	self.equipment = {
		armor: {
		},
		sword: new Tool(-1),
		//shield: new Tool(-1),
	};
	
	
	static Has = function(itemID) {
		for (var i = 0; i < array_length(self.content); i++) {
			if (self.content[i].itemID == itemID) return true;
		}
		
		return false;
	}
	
	static Remove = function(itemID) {
		for (var i = 0; i < array_length(self.content); i++) {
			if (self.content[i].itemID == itemID) {
				ds_list_delete(self.content, i);
			}
		}
	}
	
	static Add = function(itemID) {
		var item = new Tool(itemID);
		
		// Add gold to player's gold count instead of Tool
		if (itemID == ITEM_ID.Gold) {
			Player.gold ++;
			return;
		}
		
		print($"Inventory: added { itemID}");
		array_push(self.content, item);
	}
	
	static GetListOf = function(type) {
	}
	
	static DrawSlot = function(slotPointer, slotSize, yoffset = 0, color = c_gray) {
		var scale = Style.guiScale;
		
		var sprite = sInventorySlot;
		var sw = sprite_get_width(sprite) * scale;
		var sh = sprite_get_height(sprite) * scale;
		
		var yy = (HEIGHT / 2) + yoffset * (sh + 5);
		
		for (var i = 0; i < slotSize; i++) {
			var index = 1;
			if (i == 0) index = 0;
			if (i == slotSize - 1) index = 2;
			
			var xx = (WIDTH / 2) + (i * sw) - slotSize / 2 * sw;
			
			draw_sprite_ext(sprite, index, xx + sw, yy, scale, scale, 0, color, 1);
		}
		
		var key = "item_" + string(self.content[slotPointer].itemID);
		var name = TRANSLATION.Get(key, Language);
		
		draw_set_halign(fa_left);
		var textScale = scale / 1.5;
		draw_text_transformed_colour((WIDTH / 2) - (slotSize / 2 * sw) + 10, yy, name, textScale, textScale, 0, color, color, color, color, 1);
		
		draw_set_halign(fa_center);
	}
	
	self.colorscheme = {
		section: {
			item: {
				background: 0x210E1C,
			},
			
			stats: {
			},
			
			background: 0x110A0C,
		},
	};
	self.sectionItemLeft = 0;
	
	static Draw = function() {
		var scale = Style.guiScale;
		
		// Draw half transparent black rectangle 
		draw_set_alpha(0.66);
		draw_rectangle_color(0, 0, WIDTH, HEIGHT, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		
		
		// Background
		var c0 = self.colorscheme.section.background;
		draw_rectangle_color(0, 0, WIDTH, HEIGHT, c0, c0, c0, c0, false);
		
		
		// Player Stats
		draw_text_outline(self.sectionItemLeft / 2, 50, "STATS", scale, scale, 0, 1, fnt_console, c_black, c_white);
		draw_sprite_ext(sPlayerOneEye_Attack, current_time / 100, self.sectionItemLeft / 2, 150, 5, 5, 0, c_white, 1);
		
		
		// Items
		var slotSize = 10;
		var sprite = sInventorySlot;
		var sw = sprite_get_width(sprite) * scale;
		var sh = sprite_get_height(sprite) * scale;
		
		var xx = (WIDTH / 2);
		var yy = (HEIGHT / 2);
		
		var c0 = self.colorscheme.section.item.background;
		var padding = 5;
		
		self.sectionItemLeft = (xx - slotSize * sw / 2) - padding;
		self.sectionItemRight = (xx + slotSize * sw / 2) + padding;
		
		
		draw_rectangle_color(
			self.sectionItemLeft, 
			0,
			self.sectionItemRight, 
			yy + HEIGHT + padding, 
			c0, c0, c0, c0, false
		);
		
		draw_line_width(self.sectionItemLeft, yy - sh / 2 - padding, self.sectionItemRight, yy - sh / 2 - padding, 2);
		
		
		for (var i = self.slotIndex; i < array_length(self.content); i++) {
			var color = c_gray;
			if (self.slotIndex == i) color = c_white;
			self.DrawSlot(i, slotSize, i - self.slotIndex, color);
			
			if (Keymap.player.jump && !self.itemSelected) {
				self.itemSelected = i;
			}
		}
		
		
		// Item Navigation
		if (self.section == INVENTORY_SECTION.Items && !self.itemSelected) {
			if (Keymap.player.downPressed && self.slotIndex < array_length(self.content) - 1) {
				self.slotIndex ++;
			}
			
			if (Keymap.player.upPressed && self.slotIndex > 0) {
				self.slotIndex --;
			}
		}
		
		
		// Draw modules
		//with (Player) {
		//	var x2 = other.sectionItemRight + (slotSize / 2.44 * sw); 
		//	var scale = 2;
			
		//	draw_text_outline(x2, 50, "MODULES", scale, scale, 0, 1, fnt_console, c_black, c_white);
			
		//	for (var i = 0; i < array_length(modules.list); i++) {
		//		var moduleID = modules.list[i];
		//		var item = ITEM.Get(moduleID).components;
		//		var icon = item.icon;
		//		var hh = sprite_get_height(icon) * scale;
		//		var ww = sprite_get_width(icon) * scale;
		//		var padding = 1.15;
				
		//		draw_sprite_ext(
		//			icon, 0, 
		//			other.sectionItemRight + ww + 10, 150 + i * hh * padding, 
		//			1.5, 1.5, 0, c_white, 1
		//		);
				
		//		draw_set_halign(fa_left);
				
		//		draw_text_outline(
		//			other.sectionItemRight + ww * 2, 150 + i * hh + padding, 
		//			item.name, 1.25, 1.25, 0, 1, fnt_console, c_black, c_white
		//		);
				
		//		draw_set_halign(fa_center);
		//	}
		//}
		
		
		// Draw item selection options
		var Option = function(name, fn, condition=true) constructor {
			self.name = name;
			self.fn = fn;
			self.condition = condition;
		}
		
		var quitOption = new Option("exit", function(itemID){
			self.itemSelected = -1;
		});
		
		if (self.itemSelected) {
			var options = [];
			var itemID = self.content[self.itemSelected].itemID;
			var item = ITEM.Get(itemID).components;
			
			switch (ITEM.GetType(itemID)) {
				
				case ITEM_TYPE.Armor:
					options = [
						// Future logic: add the armor to the players armor slot, and swap if it already exists, adding the old armor to self.content
						new Option("equip", function(itemID){
						}),
						
						quitOption,
					];
					
					break;
				
				case ITEM_TYPE.Module:
					options = [
						new Option("use", function(itemID){
							Player.modules.add(itemID);
						}),
						quitOption,
					];
					
					break;
				
				default:
					options = [
						quitOption,
					];
					
					break;
			}
			
			
			for (var opt = 0; opt < array_length(options); opt++) {
				var pos = new Vec2(
					(WIDTH / 2) + 200, (HEIGHT / 2)
				);
				
				var size = new Dim(
					200, 75
				);
				
				draw_rectangle(pos.x, pos.y, pos.x + size.width, pos.y + size.height, false);
			}
			
		}
	}
	
	
	
	
	
}