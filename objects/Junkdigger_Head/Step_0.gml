
tick += GameSpeed;

if (face == sBoss_Junkdigger_FE_swap) {
	faceFrame = irandom(sprite_get_number(sBoss_Junkdigger_FE_swap));
	if (tick > 15) {
		face = faceQueue;
		faceFrame = 0;
	}
}
