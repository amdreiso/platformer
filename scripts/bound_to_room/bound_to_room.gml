function bound_to_room(){
	x = clamp(x, -1, room_width + 1);
	y = clamp(y, -1, room_height + 1);
}