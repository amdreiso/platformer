function keymap_get(){
	return {
		player: {
			up:			(keyboard_check(ord("W")) || gamepad_button_check(Gamepad.ID, gp_padu) || gamepad_axis_value(Gamepad.ID, gp_axislv) < 0),
			left:		(keyboard_check(ord("A")) || gamepad_button_check(Gamepad.ID, gp_padl) || gamepad_axis_value(Gamepad.ID, gp_axislh) < 0),
			down:		(keyboard_check(ord("S")) || gamepad_button_check(Gamepad.ID, gp_padd) || gamepad_axis_value(Gamepad.ID, gp_axislv) > 0),
			right:	(keyboard_check(ord("D")) || gamepad_button_check(Gamepad.ID, gp_padr) || gamepad_axis_value(Gamepad.ID, gp_axislh) > 0),
			
			jump: (keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(Gamepad.ID, gp_face1)),
			jumpHold: (keyboard_check(vk_space) || gamepad_button_check(Gamepad.ID, gp_face1)),
			
			interact: (keyboard_check_pressed(ord("E")) || gamepad_button_check(Gamepad.ID, gp_face2)),
			attack: (keyboard_check_pressed(ord("F")) || gamepad_button_check(Gamepad.ID, gp_face3)),
			specialAttack: (keyboard_check_pressed(ord("F")) || gamepad_button_check(Gamepad.ID, gp_face3)),
		},
		
		select:				(keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(Gamepad.ID, gp_face1)),
		selectUp:			(keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(Gamepad.ID, gp_padu)),
		selectLeft:		(keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(Gamepad.ID, gp_padl)),
		selectDown:		(keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(Gamepad.ID, gp_padd)),
		selectRight:	(keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(Gamepad.ID, gp_padr)),
		
		pause: (keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(Gamepad.ID, gp_start)),
	}
}