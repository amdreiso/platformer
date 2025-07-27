function gamepad_menu(minimum, maximum){
	
	if (Keymap.paddPressed && GamepadMenuIndex < maximum) {
		GamepadMenuIndex ++;
	}
	
	if (Keymap.paduPressed && GamepadMenuIndex > minimum) {
		GamepadMenuIndex --;
	}
	
}