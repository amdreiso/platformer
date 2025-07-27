function gp_anykey(){
	
  var dz = abs(0.25);
	var con = (
			
		gamepad_button_check(Gamepad.ID,gp_extra1) ||
		gamepad_button_check(Gamepad.ID,gp_extra2) ||
		gamepad_button_check(Gamepad.ID,gp_extra3) ||
		gamepad_button_check(Gamepad.ID,gp_extra4) ||
		gamepad_button_check(Gamepad.ID,gp_extra5) ||
		gamepad_button_check(Gamepad.ID,gp_face1) ||
		gamepad_button_check(Gamepad.ID,gp_face2) ||
		gamepad_button_check(Gamepad.ID,gp_face3) ||
		gamepad_button_check(Gamepad.ID,gp_face4) ||
		gamepad_button_check(Gamepad.ID,gp_home) ||
		gamepad_button_check(Gamepad.ID,gp_start) ||
		gamepad_button_check(Gamepad.ID,gp_select) ||
		gamepad_button_check(Gamepad.ID,gp_shoulderr) ||
		gamepad_button_check(Gamepad.ID,gp_shoulderl) ||
		gamepad_button_check(Gamepad.ID,gp_shoulderrb) ||
		gamepad_button_check(Gamepad.ID,gp_shoulderlb) ||
		gamepad_button_check(Gamepad.ID,gp_padd) ||
		gamepad_button_check(Gamepad.ID,gp_padu) ||
		gamepad_button_check(Gamepad.ID,gp_padr) ||
		gamepad_button_check(Gamepad.ID,gp_padl) ||
		gamepad_button_check(Gamepad.ID,gp_paddlel) ||
		gamepad_button_check(Gamepad.ID,gp_paddler) ||
		gamepad_button_check(Gamepad.ID,gp_paddlelb) ||
		gamepad_button_check(Gamepad.ID,gp_paddlerb) ||
		gamepad_button_check(Gamepad.ID,gp_stickl) ||
		gamepad_button_check(Gamepad.ID,gp_stickr) ||
		gamepad_button_check(Gamepad.ID,gp_touchpadbutton) ||
			
		abs(gamepad_axis_value(Gamepad.ID, gp_axislh)) > dz ||
		abs(gamepad_axis_value(Gamepad.ID, gp_axislv)) > dz ||
		abs(gamepad_axis_value(Gamepad.ID, gp_axisrh)) > dz ||
		abs(gamepad_axis_value(Gamepad.ID, gp_axisrv)) > dz
			
	);
		
	return con;
}