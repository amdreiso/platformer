
draw_self();


hitFog = max(0, hitFog - GameSpeed);


gpu_set_fog((hitFog > 0), c_white, 0, 1);

draw_sprite_ext(face, faceFrame, x, y, xscale, 1, 0, c_white, 1);

gpu_set_fog(false, c_white, 0, 1);