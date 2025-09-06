function room_transition(roomID, side, onEnter=function(){}, transitionTime = 0.33){
	
	Main.transitionOutput = roomID;
	Main.transitionPlayerPosition = vec2(Player.x, Player.y);
	Main.transitionTime = transitionTime;
	Main.transitionOnEnter = onEnter;
	Main.transition = true;
	Main.transitionSide = side;
	
}