
depth = -99999;

y -= 0.05 * GameSpeed;

tick += GameSpeed;
if (tick > lifetime) instance_destroy();

yscale = lerp(yscale, 1, 0.05);


draw_text_outline(x, y, value, scale, scale * yscale, 0, 1, fnt_damageIndicator, c_black, color);

