
var item = ITEM.get(itemID);

if (place_meeting(x, y, Player)) {
	if (!picked && item.sprite != -1) {
		draw_key(KEY_INDICATOR.Interact);
	}
}
