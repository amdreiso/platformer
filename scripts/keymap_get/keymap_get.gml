function keymap_get(){
	return {
		player: {
			up:			(keyboard_check(ord("W"))),
			left:		(keyboard_check(ord("A"))),
			down:		(keyboard_check(ord("S"))),
			right:	(keyboard_check(ord("D"))),
			
			jump: (keyboard_check_pressed(vk_space)),
			jumpHold: (keyboard_check(vk_space)),
			
			interact: (keyboard_check_pressed(ord("E"))),
			attack: (keyboard_check_pressed(ord("F"))),
			specialAttack: (keyboard_check_pressed(ord("F"))),
		},
	}
}