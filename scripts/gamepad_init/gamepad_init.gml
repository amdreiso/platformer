function gamepad_init(){
	
	Gamepad = {};
	Gamepad.ID = -1;
	Gamepad.deadzone = 0.20;
	gamepad_find();
	
}