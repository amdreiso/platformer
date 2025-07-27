
event_inherited();

output = {
	roomID: -1,
	playerPosition: vec2(),
	onEnter: function(){},
	transitionTime: 0.07,
}

trigger = function() {
	room_transition(output.roomID, output.playerPosition, output.onEnter, output.transitionTime);
}
