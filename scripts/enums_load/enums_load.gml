function enums_load(){

enum ACHIEVEMENT_TYPE {
	Item,
	Location,
	Enemy,
	Blank,
}

enum ACHIEVEMENT_ID {
	TheseWallsLookFake,
	GoldAge,
}

enum LEVEL_SECTION {
	Caves,
	Garden,
}

enum DIMENSION_ID {
	Main,
	Garden,
	Neptune,
}

enum ITEM_TYPE {
	Blank,
	Key,
	Armor,
	Ring,
	Sword,
	Spell,
	Module,
}

enum ITEM_ID {
	Gold,
	
	ScrapElectronics,
	Jetpack,
	BaseballBat,
	
	FlameSpell,
	FreezeSpell,
	KnockbackSpell,
	StrengthSpell,
	PoisonSpell,
	
	DevStick,
	
	Armor,
	
	HighJumpModule,
	PortalCasterModule,
	
	Dynamite,
	
	Count,
}

enum SPELL_ID {
	Flames,
	Freeze,
	Knockback,
	Strength,
	Poison,
}

enum EFFECT_ID {
	Burning,
	Frozen,
	Poison,
	
}

enum SUBITEM_ID {
	WaterBucket,
}

enum LANGUAGE_ID {
	English,
	Brazilian,
	Count,
}

enum SOUL_TYPE {
	Castoff,
	Royal,
}

enum CUTSCENE_EVENT {
	Textbox,
	Move,
	Sleep,
	WaitFor,
}


}