
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
				create: function(){},
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
		darkness: 1,
		isCutscene: true,
		
		backgroundSong: snd_mechanicalHope,
		
	});
	
	#region Caves
	
	LEVEL.register(rmLevel_Cave_Entrance, "cave entrance", {
		darkness: 0.95,
		
		backgroundSong: snd_mechanicalHope,
		
		create: function() {
			
			var broken0 = CurrentChapter.cave_entrance.hidden_wall_0.isBroken;
			
			if (!broken0) {
				var f = instance_create_layer(0, 400, "Instances", FakeWall);
				f.sprite = sFakewall1;
				f.onDestroy = function() {
					CurrentChapter.cave_entrance.hidden_wall_0.isBroken = true;
					STORY.save();
				}
			}
			
		},
	});
	
	LEVEL.register(rmLevel_Cave_Village, "village", {
		darkness: 0.90,
		
		backgroundSong: snd_dreamsOfAnElectricMind,
		
		roomCode: function() {
			parallax_set("Parallax_1", 0.60, -1);
		}
	});
	
	LEVEL.register(rmLevel_Cave_DumpYard, "dump yard", {
		darkness: 0.00,
		playerVision: 0.33,
		
		backgroundSong: snd_forgottenSpace,
		
		create: function() {
			// Boss code
			if (!CurrentChapter.dump_yard.boss_0.defeated) {
				// Create boss entrance cutscene
				instance_create_depth(0, 0, 0, Cutscene_Junkeeper);
			}
		}
	});
	
	LEVEL.register(rmLevel_Cave_Hidden_1, "hidden 1", {
		darkness: 0.00,
		playerVision: 0.33,
		
	});
	
	#endregion
	
}
