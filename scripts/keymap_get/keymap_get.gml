function keymap_get(){
	return {
		player: {
			up:			(keyboard_check(vk_up)		|| keyboard_check(ord("W")) || gamepad_button_check(Gamepad.ID, gp_padu) || gamepad_axis_value(Gamepad.ID, gp_axislv) < 0),
			left:		(keyboard_check(vk_left)	|| keyboard_check(ord("A")) || gamepad_button_check(Gamepad.ID, gp_padl) || gamepad_axis_value(Gamepad.ID, gp_axislh) < 0),
			down:		(keyboard_check(vk_down)	|| keyboard_check(ord("S")) || gamepad_button_check(Gamepad.ID, gp_padd) || gamepad_axis_value(Gamepad.ID, gp_axislv) > 0),
			right:	(keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(Gamepad.ID, gp_padr) || gamepad_axis_value(Gamepad.ID, gp_axislh) > 0),
			upPressed:			(keyboard_check_pressed(vk_up)		|| gamepad_button_check_pressed(Gamepad.ID, gp_padu)),
			leftPressed:		(keyboard_check_pressed(vk_left)	|| gamepad_button_check_pressed(Gamepad.ID, gp_padl)),
			downPressed:		(keyboard_check_pressed(vk_down)	|| gamepad_button_check_pressed(Gamepad.ID, gp_padd)),
			rightPressed:		(keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(Gamepad.ID, gp_padr)),
			
			jump: (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(Gamepad.ID, gp_face1)),
			jumpHold: (keyboard_check(ord("Z")) || keyboard_check(vk_space) || gamepad_button_check(Gamepad.ID, gp_face1)),
			
			interact: (keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(Gamepad.ID, gp_face2)),
			interactDoor: (keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(Gamepad.ID, gp_face2)),
			cancel: (keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(Gamepad.ID, gp_face2)),
			attack: (keyboard_check_pressed(ord("X")) || gamepad_button_check(Gamepad.ID, gp_face3)),
			specialAttack: (keyboard_check_pressed(ord("X")) || gamepad_button_check(Gamepad.ID, gp_face3)),
			
			useItem: (keyboard_check(ord("S"))),
			
			inventory: (keyboard_check_pressed(ord("V")) || gamepad_button_check_pressed(Gamepad.ID, gp_face4)),
			
			swapWeapon: (keyboard_check_pressed(ord("C"))),
			
			module0: (keyboard_check_pressed(ord("1")) || gamepad_button_check_pressed(Gamepad.ID, gp_shoulderl)),
			module1: (keyboard_check_pressed(ord("2")) || gamepad_button_check_pressed(Gamepad.ID, gp_shoulderlb)),
			module2: (keyboard_check_pressed(ord("3")) || gamepad_button_check_pressed(Gamepad.ID, gp_shoulderr)),
			module3: (keyboard_check_pressed(ord("4")) || gamepad_button_check_pressed(Gamepad.ID, gp_shoulderrb)),
		},
		
		select:								(keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(Gamepad.ID, gp_face1)),
		selectUp:							(keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(Gamepad.ID, gp_padu) || gamepad_axis_value(Gamepad.ID, gp_axislv) < 0),
		selectLeft:						(keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(Gamepad.ID, gp_padl) || gamepad_axis_value(Gamepad.ID, gp_axislh) < 0),
		selectDown:						(keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(Gamepad.ID, gp_padd) || gamepad_axis_value(Gamepad.ID, gp_axislv) > 0),
		selectRight:					(keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(Gamepad.ID, gp_padr) || gamepad_axis_value(Gamepad.ID, gp_axislh) > 0),
		
		selectLeftHold:				(keyboard_check(vk_left) || gamepad_button_check(Gamepad.ID, gp_padl) || gamepad_axis_value(Gamepad.ID, gp_axislh) < 0),
		selectRightHold:			(keyboard_check(vk_right) || gamepad_button_check(Gamepad.ID, gp_padr) || gamepad_axis_value(Gamepad.ID, gp_axislh) > 0),
		
		pause:								(gamepad_button_check_pressed(Gamepad.ID, gp_start)),
	}
}
