
event_inherited();

x += hdir * spd;
y += vdir * spd + (sin(current_time * 0.001) * 3);

scale = sin(current_time * 0.001) * 1.5;
