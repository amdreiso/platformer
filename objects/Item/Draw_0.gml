
if (itemID == -1) return;

// Draw item
var item = ITEM.Get(itemID);
var sprite = item.components.sprite;
if (sprite != -1) {
	sprite_index = sprite;
	draw_sprite_ext(sprite, 0, x, y, xscale, 1, angle, color, alpha);
}

if (place_meeting(x, y, Player)) {
	// Add item to player's inventory
	if (!picked) Player.inventory.Add( itemID );

	picked = true;
	applyGravity = false;
}

// Animation when picked
if (!picked) return;

y -= 0.6;
alpha = lerp(alpha, 0, 0.1);

if (alpha < 0.05) {
	instance_destroy();
}




