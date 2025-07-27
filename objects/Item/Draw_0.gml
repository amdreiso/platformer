
if (itemID == -1) return;

// Draw item
var item = ITEM.get(itemID);
if (item.sprite != -1) {
	sprite_index = item.sprite;
	draw_sprite_ext(item.sprite, 0, x, y, xscale, 1, angle, color, alpha);
}

if (place_meeting(x, y, Player)) {
	if (!picked)
		draw_outline(1, angle, Style.outlineColor, alpha);
	
	if (keyboard_check_pressed(ord("E"))) {
		picked = true;
		applyGravity = false;
		
		// Add item to player's inventory
		Player.inventory.add( itemID );
	}
}

// Animation when picked
if (!picked) return;

y -= 0.6;
alpha = lerp(alpha, 0, 0.1);

if (alpha < 0.05) {
	instance_destroy();
}


