
camera_shake(5, 2);

sound_play(SOUND_TYPE.SFX, snd_explosion1, false);

create_explosion_particles(x, y, 32);

gamepad_set_vibration(Gamepad.ID, 1, 1);
