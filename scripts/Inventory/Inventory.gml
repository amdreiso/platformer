function InventorySlot(itemID) constructor {
	self.itemID = itemID;
}

function Inventory(w = 5, h = 5) constructor {
	self.width = w;
	self.height = h;
	
	// Content
	self.content = [];
	self.slotIndex = 0;
	
	enum INVENTORY_SECTION {
		Items,
		Equipment,
	}
	
	self.section = INVENTORY_SECTION.Items;
	
	
	// Equipment, armor, swords, etc
	self.equipment = {
		armor: {
		},
		sword: new Tool(-1),
		shield: new Tool(-1),
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
		
		var name = TRANSLATION.Get(self.content[slotPointer].itemID, Language);
		
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
		var slotSize = 6;
		
		// Draw half transparent black rectangle 
		draw_set_alpha(0.66);
		draw_rectangle_color(0, 0, WIDTH, HEIGHT, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		
		
		// Background
		var c0 = self.colorscheme.section.background;
		draw_rectangle_colour(0, 0, WIDTH, HEIGHT, c0, c0, c0, c0, false);
		
		
		// Player Stats
		draw_sprite_ext(sPlayerOneEye_Attack, current_time / 100, self.sectionItemLeft / 2, 100, 5, 5, 0, c_white, 1);
		
		
		
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
		}
		
		
		// Item Navigation
		if (self.section == INVENTORY_SECTION.Items) {
			if (Keymap.player.downPressed && self.slotIndex < array_length(self.content) - 1) {
				self.slotIndex ++;
			}
			
			if (Keymap.player.upPressed && self.slotIndex > 0) {
				self.slotIndex --;
			}
		}
		
		
	}
	
	
	
	
	
}