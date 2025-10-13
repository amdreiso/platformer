
/*

spell_init contains all of the spells components
such as what effects it will give when the player attacks with an item with a spell
and what modifiers it will apply to the PlayerAttack object

*/

function spell_init(){
	
	globalvar SpellData; SpellData = ds_map_create();
	globalvar SPELL;
	
	SPELL = {
		
		register : function(spellID, effectID, applyAttackModifiers = function(){}) {
			var s = {};
			s.effectID = effectID;
			s.applyAttackModifiers = applyAttackModifiers;
			
			SpellData[? spellID] = s;
		},
		
		get: function(spellID) {
			return (SpellData[? spellID] ?? undefined);
		},
		
	}
	
	SPELL.register(SPELL_ID.Flames, EFFECT_ID.Burning, function(attack) {
		if (!instance_exists(attack)) return;
		attack.damage = attack.damage * 1.10;
		
	});
	
	SPELL.register(SPELL_ID.Freeze, EFFECT_ID.Frozen, function(attack) {
		if (!instance_exists(attack)) return;
		
	});
	
	SPELL.register(SPELL_ID.Knockback, -1, function(attack) {
		if (!instance_exists(attack)) return;
		attack.knockback = 10;
		
	});
	
	SPELL.register(SPELL_ID.Strength, -1, function(attack) {
		if (!instance_exists(attack)) return;
		attack.damage = attack.damage * 1.50;
		
	});
	
	
}