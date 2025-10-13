function room_transition(roomID, side, onEnter=function(){}, transitionTime = 0.13, transitionPlayerOffset = vec2()){
	
	Main.transitionOutput = roomID;
	Main.transitionPlayerPosition = vec2(Player.x, Player.y);
	Main.transitionPlayerOffset = transitionPlayerOffset;
	Main.transitionTime = transitionTime;
	Main.transitionOnEnter = onEnter;
	Main.transition = true;
	Main.transitionSide = side;
	
	if (instance_exists(Player)) Player.levelTransitionCooldown = 15;
	
}