
reach = place_meeting(x, y, Player);

if (reach && !active) {
	if (Keymap.player.interact && !Player.busy) {
		active = true;
		camera_set_zoom(0.75);
		savingString = "saving";
		
	}
}

if (active) {
	Player.x = approach(Player.x, x - 1, 1);
	Player.y = approach(Player.y, y - Player.sprite_height / 2, 1);
	Player.busy = true;
	Player.halt();
	Player.image_xscale = image_xscale;
	
	camera_shake(random_range(0.50, 1.00) / 2);
	
	tick += GameSpeed;
	var interval = 60;
	if (floor(tick) % interval == true) {
		var prefix = "saving";
		if (savingString == prefix) {
			savingString = prefix+".";
		} else if (savingString == prefix+".") {
			savingString = prefix+"..";
		} else if (savingString == prefix+"..") {
			savingString = prefix+"...";
		} else if (savingString == prefix+"...") {
			savingString = prefix;
		}
	}
	
	if (tick == 4 * interval) {
		active = false;
		tick = 0;
		camera_set_zoom(CAMERA_ZOOM_DEFAULT);
		
		SaveManager.SavePlayer(x - 1, y - Player.sprite_height / 2);
		SaveManager.Save();
	}
	
}
