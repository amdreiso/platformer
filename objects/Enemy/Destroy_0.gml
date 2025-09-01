
audio_play_sound(deathSound, 0, false, 0.5, 0, random_range(0.80, 1.00));

camera_shake(1);
create_explosion_particles(x, y - 10, sprite_width, sprite_get_width(spriteStates.idle) + sprite_get_height(spriteStates.move) / 4, random_range(0.05, 0.15));
