
var target = active ? sDoor2_active : sDoor2;

if (sprite_index != target) {
  sprite_index = target;
	
	var num = sprite_get_number(sprite_index) - 1;
  
	image_index = 0;
  image_speed = 0;
	
  if (animation) {
    image_speed = 1;
    ranLastFrame = false;
  }
}

if (animation && !ranLastFrame) {
  if (floor(image_index) >= sprite_get_number(sprite_index) - 1) {
    image_speed = 0;
    animation = false;
    ranLastFrame = true;
  }
}

draw_self();

if (output.roomID == -1) return false;

if (!active) {
	if (place_meeting(x, y, Player)) {
		draw_key(sButton_W);
		
		if (keyboard_check_pressed(ord("W"))) {
			output.onEnter();
			//room_goto(output.roomID);
			room_transition(output.roomID, output.playerPosition);
		}
	}
}

