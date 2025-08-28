
face = sBoss_Junkdigger_FE_cringe;
faceQueue = -1;
faceFrame = 0;
xscale = 1;

tick = 0;

changeFacialExpression = function(sprite) {
	if (face == sprite || faceQueue == sprite) return;
	
	faceQueue = sprite;
	face = sBoss_Junkdigger_FE_swap;
	
	tick = 0;
}
