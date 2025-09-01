
if (!instance_exists(Player)) return;

var amp = 5;
var time = 0.001;

x = lerp(x, Player.x + playerOffset.x + sin(current_time * time) * amp, 0.01);
y = lerp(y, Player.y - playerOffset.y + cos(current_time * time / 1.25) * amp, 0.1);
