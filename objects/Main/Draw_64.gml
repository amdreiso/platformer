

// Screen flash
var c = screenFlashColor;
screenFlashTime = max(0, screenFlashTime - screenFlashDecrement);

draw_set_alpha(screenFlashTime);
draw_rectangle_color(0, 0, WIDTH, HEIGHT, c, c, c, c, false);
draw_set_alpha(1);


// Room transition stuff
draw_room_transition();

if (instance_exists(Level)) then Level.drawScreenlog();

CONSOLE.Draw();

