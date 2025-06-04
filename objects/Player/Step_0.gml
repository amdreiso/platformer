
busy = (Paused 
				|| instance_exists(Textbox) 
				|| Console
);

movement();

applyCollisions();

attack();
handleHealth();
handleBackflip();


// Audio
audio_listener_position(x, y, 0);


if (!instance_exists(Camera)) {
	var cam = instance_create_depth(x, y, depth, Camera);
	cam.target = self;
}


// Debug thingies
if (!Debug) return;

if (keyboard_check(vk_control)) {
	if (mouse_check_button(mb_left)) {
		x = mouse_x;
		y = mouse_y;
	}
}




