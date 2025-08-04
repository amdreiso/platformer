/// @desc Draws a key on the screen as a hint
/// @param {string} keyboard Description
/// @param {string} [gamepad]=keyboard Description
function draw_key(keyboard, gamepad = keyboard){
	
	var spr = keyboard;
	if (CurrentController == CONTROLLER_INPUT.Gamepad) spr = gamepad;
	
	var margin = 75;
	var xx = WIDTH - margin;
	var yy = HEIGHT - margin;
	var scale = 4;
	
	draw_sprite_ext(spr, 0, xx, yy, scale, scale, 0, c_white, 1);
	
}