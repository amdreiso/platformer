
signalID = 0;
active = false;

doSwitch = false;
animation = 0;

time = 3 * 60;
tick = time;

onActivation = function() {
	Level.signals.Send(new Signal(signalID, time));
}
