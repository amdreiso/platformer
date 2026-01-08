
function InventorySlot(itemID) constructor {
	self.itemID = itemID;
}

function Inventory() constructor {

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
		armor: {},
		sword: new Tool(-1),
		
	};
	
	static Sort = function() {
		array_sort(self.content, function(a, b) {
			var ta = a.itemID;
			var tb = b.itemID;
			
			var tat = ITEM.GetType(ta);
			var tbt = ITEM.GetType(tb);
			
			return tat - tbt;
		});
	}
	
	static Has = function(itemID) {
		for (var i = 0; i < array_length(self.content); i++) {
			if (self.content[i].itemID == itemID) return true;
		}
		
		return false;
	}
	
	static Remove = function(itemID) {
		for (var i = 0; i < array_length(self.content); i++) {
			if (self.content[i].itemID == itemID) {
				array_delete(self.content, i, 1);
			}
		}
		self.Sort();
	}
	
	static Add = function(itemID, spells = new ToolSpells()) {
		var item = new Tool(itemID, spells);
		
		// Add gold to player's gold count instead of Tool
		if (itemID == ITEM_ID.Gold) {
			Player.gold ++;
			ACHIEVEMENT.Try(ACHIEVEMENT_TYPE.Item);
			return;
		}
		
		print($"Inventory: added { TRANSLATION.Get("item_" + string(itemID))} with these spells: { spells}");
		array_push(self.content, item);
		
		ACHIEVEMENT.Try(ACHIEVEMENT_TYPE.Item);
		
		self.Sort();
	}
	
	static GetListOf = function(type) {
	}
	
	static DrawSlot = function(x, y, slotPointer, slotSize, yoffset = 0, color = c_gray) {
		var scale = Style.guiScale;
		
		var hh = 32;
		var yy = (y) + yoffset * (hh + 5);
		
		var itemID = self.content[slotPointer].itemID;
		var item = ITEM.Get(itemID);
		
		var namekey = "item_" + string(itemID);
		var name = TRANSLATION.Get(namekey);
		
		var typekey = "item_type_" + string(item.components.type);
		var type = TRANSLATION.Get(typekey)
		
		var icon = item.components.icon;
		var iconScale = 1;
		
		if (icon != -1) then draw_sprite_ext(icon, 0, x + 8, yy, iconScale, iconScale, 0, color, 1);
		
		draw_set_halign(fa_left);
		var textScale = scale / 2;
		draw_text_transformed_colour(x + 32, yy, name, textScale, textScale, 0, color, color, color, color, 1);
		
		draw_set_halign(fa_right);
		draw_text_transformed_colour(WIDTH - 32, yy, type, textScale, textScale, 0, color, color, color, color, 1);
		
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
		
		// Background
		//var c0 = self.colorscheme.section.background;
		//draw_rectangle_color(0, 0, WIDTH, HEIGHT, c0, c0, c0, c0, false);
		
		
		var width = WIDTH;
		var padding = 15;
		var radius = 10;
		var alpha = 0.95;
		static prompt = false;
		
		#region STATS
		
		var size0 = 0.35;
		var x0 = (width * size0) / 2;
		var y0 = 100;
		
		draw_set_alpha(alpha);
		draw_rectangle_colour(padding, padding, width * size0 - padding, HEIGHT - padding, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		if (self.section == INVENTORY_SECTION.Equipment) then draw_rectangle_colour(padding, padding, width * size0 - padding, HEIGHT - padding, Style.rainbow, Style.rainbow, Style.rainbow, Style.rainbow, true);
		
		// Player Display
		var plScale = 4;
		draw_sprite_ext(sPlayer_Attack, current_time / 100, x0, y0, plScale, plScale, 0, c_white, 1);
		
		// Player Slots
		var plSlotSize = 32;
		var plSlotMargin = 100;
		var plLineOffset = 32;
		
		// Armor slot
		rect(x0 - plSlotMargin, y0, plSlotSize, plSlotSize, c_white, true);
		draw_set_halign(fa_center);
		draw_text_color(x0 - plSlotMargin, y0 + plSlotSize - 5, TRANSLATION.Get("gui_inventory_slot_armor"), c_white, c_white, c_white, c_white, 0.75);
		
		// Sword slot
		rect(x0 + plSlotMargin, y0, plSlotSize, plSlotSize, c_white, true);
		draw_set_halign(fa_center);
		draw_text_color(x0 + plSlotMargin, y0 + plSlotSize - 5, TRANSLATION.Get("gui_inventory_slot_sword"), c_white, c_white, c_white, c_white, 0.75);
		
		// Modules
		var plSlotBottomY = 190;
		var plSlotModuleMargin = 1.5;
		var p = TRANSLATION.Get("gui_inventory_slot_module");
		
		var iconScale = 1;
		
		// Module 1
		rect(x0 - plSlotMargin / plSlotModuleMargin, plSlotBottomY, plSlotSize, plSlotSize, c_white, true);
		draw_text_color(x0 - plSlotMargin / plSlotModuleMargin, plSlotBottomY + plSlotSize - 5, p + " 1", c_white, c_white, c_white, c_white, 0.75);
		
		var m0 = Player.modules.Get(0), icon0;
		if (m0 != -1) {
			m0 = ITEM.Get(m0);
			icon0 = m0.components.icon;
		
			draw_sprite_ext(icon0, 0, x0 - plSlotMargin / plSlotModuleMargin, plSlotBottomY, iconScale, iconScale, 0, c_white, 1);
		}
		
		// Module 2
		rect(x0, plSlotBottomY, plSlotSize, plSlotSize, c_white, true);
		draw_text_color(x0, plSlotBottomY + plSlotSize - 5, p + " 2", c_white, c_white, c_white, c_white, 0.75);
		
		var m1 = Player.modules.Get(1), icon1;
		if (m1 != -1) {
			m1 = ITEM.Get(m1);
			icon1 = m1.components.icon;
		
			draw_sprite_ext(icon1, 0, x0, plSlotBottomY, iconScale, iconScale, 0, c_white, 1);
		}
		
		
		// Module 3
		rect(x0 + plSlotMargin / plSlotModuleMargin, plSlotBottomY, plSlotSize, plSlotSize, c_white, true);
		draw_text_color(x0 + plSlotMargin / plSlotModuleMargin, plSlotBottomY + plSlotSize - 5, p + " 3", c_white, c_white, c_white, c_white, 0.75);

		var m2 = Player.modules.Get(2), icon2;
		if (m2 != -1) {
			m2 = ITEM.Get(m2);
			icon2 = m2.components.icon;
		
			draw_sprite_ext(icon2, 0, x0 + plSlotMargin / plSlotModuleMargin, plSlotBottomY, iconScale, iconScale, 0, c_white, 1);
		}
		
		
		#endregion
		
		#region ITEMS
		
		var size1 = 1;
		
		draw_set_alpha(alpha);
		draw_rectangle_color(width * size0 + padding, padding, width * size1 - padding, HEIGHT - padding, c_black, c_black, c_black, c_black, false);
		draw_set_alpha(1);
		if (self.section == INVENTORY_SECTION.Items) then draw_rectangle_color(width * size0 + padding, padding, width * size1 - padding, HEIGHT - padding, Style.rainbow, Style.rainbow, Style.rainbow, Style.rainbow, true);
		
		#endregion
		
		
		// Items
		var slotSize = 10;
		var sprite = sInventorySlot;
		var sw = sprite_get_width(sprite) * scale;
		var sh = sprite_get_height(sprite) * scale;
		
		var xx = (width * size0 + width * size1) / 2;
		var yy = 100;
		
		var c0 = self.colorscheme.section.item.background;
		var itemPadding = 5;
		
		self.sectionItemLeft = (xx - slotSize * sw / 2) - itemPadding;
		self.sectionItemRight = (xx + slotSize * sw / 2) + itemPadding;
		
		var color = c_white;
		
		draw_set_halign(fa_left);
		var textScale = scale / 2;
		draw_text_transformed_colour(xx - (width * 0.65 - 2 * padding) / 2 + padding, yy / 2, TRANSLATION.Get("gui_inventory_name"), textScale, textScale, 0, color, color, color, color, 1);
		
		draw_set_halign(fa_right);
		draw_text_transformed_colour(WIDTH - 32, yy / 2, TRANSLATION.Get("gui_inventory_type"), textScale, textScale, 0, color, color, color, color, 1);
		
		for (var i = self.slotIndex; i < array_length(self.content); i++) {
			var color = c_gray;
			if (self.slotIndex == i) {
				color = c_white;
				
				var c1 = Style.rainbow;
				draw_set_alpha(0.13);
				var h = 16;
				draw_rectangle_colour(xx - (width * 0.65 - 2 * padding) / 2, yy - h, WIDTH - padding, yy + h, c1, c1, c1, c1, false);
				draw_set_alpha(1);
			}
			
			self.DrawSlot(xx - (width * 0.65 - 2 * padding) / 2 + padding, yy, i, slotSize, i - self.slotIndex, color);
			
			if (Keymap.select && self.itemSelected == -1 && !prompt) {
				self.itemSelected = i;
				print($"Inventory: selected item {TRANSLATION.Get("item_" + string(self.content[self.itemSelected].itemID))}");
				prompt = true;
				Keymap.select = false; // consume
			}
		}
		
		
		// Item Navigation
		if (self.section == INVENTORY_SECTION.Items && self.itemSelected == -1) {
			if (Keymap.player.downPressed && self.slotIndex < array_length(self.content) - 1) {
				self.slotIndex ++;
			}
			
			if (Keymap.player.upPressed && self.slotIndex > 0) {
				self.slotIndex --;
			}
			
			if (Keymap.player.rightPressed) {
				currentType = ITEM.GetType(self.content[self.slotIndex].itemID);
				
				while (self.slotIndex < array_length(self.content) - 1) {
					self.slotIndex ++;
					if (ITEM.GetType(self.content[self.slotIndex].itemID) != currentType) {
						break;
					}
				}
			}
			
			if (Keymap.player.leftPressed) {
				currentType = ITEM.GetType(self.content[self.slotIndex].itemID);
				
				while (self.slotIndex > 0) {
					self.slotIndex --;
					if (ITEM.GetType(self.content[self.slotIndex].itemID) != currentType) {
						break;
					}
				}
			}
		}
		
		
		// Draw item selection options
		var Option = function(name, fn, condition=true) constructor {
			self.name = name;
			self.fn = fn;
			self.condition = condition;
		}
		
		var quitOption = new Option("exit", function(itemID){
			self.itemSelected = -1;
			Keymap.select = false; // consume
		});
		
		var moduleOption = function() {
			return new Option()
		}
		
		if (self.itemSelected != -1) {
			var options = [];
			var tool = self.content[self.itemSelected];
			var itemID = tool.itemID;
			var item = ITEM.Get(itemID).components;
			
			var type = ITEM.GetType(itemID);
			static optionIndex = 0;
			
			
			
			switch (type) {
				
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
						new Option("Module 1", function(itemID){
							var current = Player.modules.slots[0];
							if (current != -1) {
								Player.inventory.Add(current);
							}
							Player.modules.Set(0, itemID);
							Player.inventory.Remove(itemID);
						}),
						
						new Option("Module 2", function(itemID){
							var current = Player.modules.slots[1];
							if (current != -1) {
								Player.inventory.Add(current);
							}
							Player.modules.Set(1, itemID);
							Player.inventory.Remove(itemID);
						}),
						
						new Option("Module 3", function(itemID){
							var current = Player.modules.slots[2];
							if (current != -1) {
								Player.inventory.Add(current);
							}
							Player.modules.Set(2, itemID);
							Player.inventory.Remove(itemID);
						}),
						
						quitOption,
					];
					
					break;
				
				case ITEM_TYPE.Blank:
					options = [
						quitOption,
					];
					
					break;
				
				case ITEM_TYPE.Key:
					options = [
						quitOption,
					];
					
					break;
				
				case ITEM_TYPE.Spell:
					options = [
						quitOption,
					];
					
					break;
				
				case ITEM_TYPE.Sword:
					{
						options = [
							new Option("Equip", function(itemID)
							{
								var newSword = self.content[self.itemSelected];

								var oldSword = Player.inventory.equipment.sword;
								if (oldSword.itemID != -1) {
									Player.inventory.Add(oldSword.itemID, oldSword.spell);
								}

								Player.inventory.Remove(itemID);

								Player.inventory.equipment.sword = new Tool(newSword.itemID, newSword.spell);

								self.itemSelected = -1;
							}),
							quitOption
						];
						break;
					}
				
				case ITEM_TYPE.Ring:
					options = [
						quitOption,
					];
					
					break;
			}
			
			if (Keymap.player.downPressed && optionIndex < array_length(options) - 1) {
				optionIndex ++;
			}
			
			if (Keymap.player.upPressed && optionIndex > 0) {
				optionIndex --;
			}
			
			for (var opt = 0; opt < array_length(options); opt++) {
				var pos = new Vec2(
					WIDTH / 2,
					HEIGHT / 2
				);
				
				var size = new Dim(
					100, 35
				);
				
				var hh = opt * size.height;
				var option = options[opt];
				
				var bg = c_black;
				
				if (opt == optionIndex) {
					bg = c_dkgray;
				}
				
				rect(pos.x, pos.y + hh, size.width, size.height, bg, false);
				rect(pos.x, pos.y + hh, size.width, size.height, Style.rainbow, true);
				draw_set_halign(fa_center);
				draw_text(pos.x, pos.y + hh, option.name);
				draw_set_halign(fa_center);
				
			}
			
			if (Keymap.select && prompt) {
				options[optionIndex].fn(itemID);
				optionIndex = 0;
				prompt = false;
					
				self.itemSelected = -1;
				Keymap.select = false; // consume
			}
		}
	}
	
	
}