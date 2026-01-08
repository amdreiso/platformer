
x += hsp;
y += vsp;

tick += GameSpeed;

if (face == sBoss_Junkdigger_FE_swap) {
	faceFrame = irandom(sprite_get_number(sBoss_Junkdigger_FE_swap));
	if (tick > 15) {
		face = faceQueue;
		faceFrame = 0;
	}
}

if (face == sBoss_Junkdigger_FE_hurt) {
	if (tick > 60) {
		changeFacialExpression(defaultFacialExpression)
		tick = 0;
	}
}

if (!Junkdigger.nohands) return;
