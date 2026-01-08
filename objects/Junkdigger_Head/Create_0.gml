
hsp = 0;
vsp = 0;

defaultFacialExpression = sBoss_Junkdigger_FE_cringe;
face = defaultFacialExpression;
faceQueue = -1;
faceFrame = 0;
xscale = 1;

tick = 0;
hitFog = 0;

changeFacialExpression = function(sprite) {
	if (face == sprite || faceQueue == sprite) return;
	
	faceQueue = sprite;
	face = sBoss_Junkdigger_FE_swap;
	
	tick = 0;
}


castSpell = function() {
	changeFacialExpression(sBoss_Junkdigger_FE_sophisticated);
	castSpellTimer = castSpellCooldown;
	
};

castingSpell = false;
castSpellTimer = 0;
castSpellTick = 0;
castSpellCooldown = 5 * 60;

onStartPoint = false;

point0 = 190;
point1 = 800;
point = 0;

chargingSpell = 0;

usingSpellTimer = 0;
