
function level_init(){
	
	globalvar LevelData; LevelData = ds_map_create();
	globalvar LEVEL;
	
	LEVEL = {
		
		getDefaultComponents: function() {
			return {
				backgroundSong: -1,
				darkness: 0,
				playerVision: 1,
			};
		},
		
		register: function(levelID, name, components = {}) {
			var level = {};
			level.name = name;
			level.components = LEVEL.getDefaultComponents();
			
			struct_merge(level.components, components);
			
			LevelData[? levelID] = level;
		},
		
		get: function(levelID) {
			return (LevelData[? levelID] ?? undefined);
		}
		
	};
	
	
	// Initializing 
	#region Caves
	
	LEVEL.register(rmLevel_Cave_Entrance, "cave entrance", {
		darkness: 0.95,
		
		backgroundSong: snd_mechanicalHope,
	});
	
	LEVEL.register(rmLevel_Cave_Village, "village", {
		darkness: 0.90,
		
		backgroundSong: snd_dreamsOfAnElectricMind,
	});
	
	LEVEL.register(rmLevel_Cave_DumpYard, "dump yard", {
		darkness: 1.00,
		playerVision: 0.33,
		
		backgroundSong: snd_forgottenSpace,
	});
	
	#endregion
	
}
