function room_transition(roomID, playerPosition, onEnter=function(){}, transitionTime = 0.33){
	
	Main.transition = true;
	Main.transitionOutput = roomID;
	Main.transitionPlayerPosition = playerPosition;
	Main.transitionTime = transitionTime;
	Main.transitionOnEnter = onEnter;
	
}