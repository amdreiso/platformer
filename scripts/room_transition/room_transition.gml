function room_transition(roomID, playerPos, onEnter = function(){}, time = 0.07, color = c_black){
	with (Main) {
		transition = true;
		transitionTime = time;
		transitionColor = color;
		transitionOutput = roomID;
		transitionPlayerPosition = playerPos;
	}
}