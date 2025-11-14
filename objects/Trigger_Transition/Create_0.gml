
event_inherited();

output = {
	roomID: -1,
	playerPosition: new Vec2(),
	onEnter: function(){},
	transitionTime: 0.07,
}

trigger = function() {
	var pos = output.playerPosition;
	var newPos = new Vec2();
	
	room_transition(output.roomID, pos, output.onEnter, output.transitionTime);
}
