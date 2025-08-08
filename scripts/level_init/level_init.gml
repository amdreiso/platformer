
function level_init(){
	
	globalvar LevelData; LevelData = ds_map_create();
	globalvar LEVEL;
	
	LEVEL = {
		
		getDefaultComponents: function() {
			return {
				backgroundSong: -1,
				darkness: 0,
				playerVision: 1,
				isCutscene: false,
				roomCode: function(){},
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
	LEVEL.register(rmBegginingCutscene, "beggining cutscene", {
		darkness: 0,
		isCutscene: true,
		
		backgroundSong: snd_mechanicalHope,
	});
	
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
		darkness: 0.00,
		playerVision: 0.33,
		
		backgroundSong: snd_forgottenSpace,
		
		roomCode: function() {
			parallax_set("Parallax_1", 3.00);
			parallax_set("Parallax_2", 0.50);
		}
	});
	
	#endregion
	
}
