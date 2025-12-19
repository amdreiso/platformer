function gamepad_find(){
	for (var i = 0; i < gamepad_get_device_count(); i++) {
		if (gamepad_is_connected(i)) {
			Gamepad.ID = i;
			//GamepadWasFound = "found!";
			
			gamepad_set_axis_deadzone(Gamepad.ID, Gamepad.deadzone);
			
			Keymap = keymap_get();
			
			show_debug_message($"Device {i} was connected as a gamepad!");
			
			return true;
		}
	}
	
	show_debug_message("Could not connect gamepad");
	return false;
}