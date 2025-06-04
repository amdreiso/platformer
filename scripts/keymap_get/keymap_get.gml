function keymap_get(){
	var map = {
		player: {
			up: (keyboard_check(ord("W")) || keyboard_check(vk_up)),
			left: (keyboard_check(ord("A")) || keyboard_check(vk_left)),
			down: (keyboard_check(ord("S")) || keyboard_check(vk_down)),
			right: (keyboard_check(ord("D")) || keyboard_check(vk_right)),
			
			jump: (keyboard_check_pressed(vk_space)),
			jumpHold: (keyboard_check(vk_space)),
			
			interact: (keyboard_check_pressed(ord("E"))),
			switchWeapons: (keyboard_check_pressed(vk_tab)),
			
			attack: (mouse_check_button_pressed(mb_left)),
		}
	}
	
	return map;
}