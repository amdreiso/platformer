
event_inherited();

if (place_meeting(x, y, Player) && !isFixed && !talking && !destroyed) {
	var item = ITEM.get( itemToFix );
	if (item.sprite != -1) {
		draw_sprite_ext(item.sprite, 0, x, y-16, 1, 1, 0, $FF101010, 1);
		draw_sprite_ext(sQuestionMarkIcon, 0, x, y-16, 1, 1, 0, $FF9f9f9f, 1);
	}
	
	if (keyboard_check_pressed(ord("F"))) {
		isFixed = (Player.inventory.hasItem(itemToFix));
	}
}

if (isFixed) {
	dialogue = [
	];
	
	dialogue = [
		TRANSLATION.get("cave_entrance_robot_fixed_0"),
		TRANSLATION.get("cave_entrance_robot_fixed_1"),
		TRANSLATION.get("cave_entrance_robot_fixed_2"),
	];
			
	dialogueEnd = function(obj) {
		obj.destroyed = true;
		obj.dialogue = [];
	}
}
