function achievement_init(){
	
	globalvar ACHIEVEMENT;
	ACHIEVEMENT = new Registry();
	
	var defaultComponents = {
		name : "",
		type : 0,
		condition : function(){ return false; },
		unlocked : false,
	}
	
	ACHIEVEMENT.SetDefaultComponents(defaultComponents);
	
	ACHIEVEMENT.Try = function(type) {
		var arr = ds_map_keys_to_array(ACHIEVEMENT.entries);
		var len = array_length(arr);
		
		
		for (var i = 0; i < len; i++) {
			var achID = arr[i];
			var ach = ACHIEVEMENT.Get(achID);
			
			if (ach.components.type == type) {
				if (ach.components.condition()) {
					ACHIEVEMENT.Unlock(achID);
				}
			}
		}
	}
	
	ACHIEVEMENT.Unlock = function(achievementID) {
		var a = ACHIEVEMENT.Get(achievementID);
		if (a == undefined) return;
		if (a.components.unlocked) return;
		
		print($"ACHIEVEMENT: {a.components.name}");
		a.components.unlocked = true;
		
		// Save system here
	}
	
	
	ACHIEVEMENT.Register(ACHIEVEMENT_ID.TheseWallsLookFake, {
		name : "These walls look fake",
		type : ACHIEVEMENT_TYPE.Blank,
		condition : function(){},
		unlocked : false,
	});
	
	ACHIEVEMENT.Register(ACHIEVEMENT_ID.GoldAge, {
		name : "Gold age",
		type : ACHIEVEMENT_TYPE.Item,
		condition : function(){
			return (Player.gold > 0);
		},
		unlocked : false,
	});
	
	
	
}