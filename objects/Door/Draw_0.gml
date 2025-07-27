
var target = active ? sDoor1_active : sDoor1;

if (sprite_index != target) {
  sprite_index = target;
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

if (!active) {
	if (place_meeting(x, y, Player)) {
		
		if (Keymap.player.interact) {
			room_transition(
				output.roomID, 
				output.playerPosition,
				output.onEnter
			);
		}
	}
}

