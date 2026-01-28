
if (Keymap.pause) {
	active = !active;
	if (!active) { 
		buttonIndex = 0;
		page = MENU_PAGE.Home;
		settings_save();
	}
}
