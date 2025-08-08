
busy = (Paused 
				|| isDead
				|| instance_exists(Textbox) 
				|| instance_exists(PauseMenu) 
				|| Debug.console
);

movement();

applyCollisions();

attack();
handleHealth();
handleBackflip();


// Lighting
viewDistance = viewDistanceDefault * LevelData[? room].components.playerVision;

var amp = 1;
var time = 0.001;

var left = sin(current_time * time) * amp;
var right = cos(current_time * time) * amp;

gamepad_set_vibration(Gamepad.ID, 1, 1);



// Audio
audio_listener_position(x, y, 0);


if (!instance_exists(Camera)) {
	var cam = instance_create_depth(x, y, depth, Camera);
	cam.target = self;
}


// Debug thingies
if (!Debug) return;

if (keyboard_check(vk_control)) {
	noclip = (mouse_check_button(mb_left));
}







