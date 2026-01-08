
function level_init() {
	
	globalvar LEVEL;
	
	var defaultComponents = function() {
		return {
			name: "",
			dimension: DIMENSION_ID.Main,
			
			backgroundSong: -1,
			darkness : 0.5,
			isCutscene: false,
			load: function(){},
			roomCode: function(){},
			transitions: [],
			section: LEVEL_SECTION.Caves,
				
			mapOffsetPos: new Vec2(),
			mapTileColor: c_aqua,
		};
	};
	
	LEVEL = new Registry();
	LEVEL.SetDefaultComponents(defaultComponents());
	var TransitionSet = function(side, x, y, roomID, playerOffset = new Vec2(), isHidden = false) {
		var t = {};
			
		t.side = side;
		t.x = x * ROOM_TILE_WIDTH;
		t.y = y * ROOM_TILE_HEIGHT;
		t.roomID = roomID;
		t.playerOffset = playerOffset;
		t.isHidden = isHidden;
			
		return t;
	}
	
	
	#region CAVE
	
	LEVEL.Register(rmLevel_Cave_Entrance, {
		name : "Cave Entrance",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("up", 0, 0, rmLevel_Cave_SpikeCorridor),
			TransitionSet("left", 0, 0, rmLevel_Cave_Hidden_1, new Vec2(0, 0), true),
			TransitionSet("right", 2, 1, rmLevel_Cave_Corridor0),
		],
		
		load: function() {
			
			// Spawn Fakewall if not broken
			var broken0 = SaveState.progression.cave_entrance.hidden_wall_0.isBroken;
			
			if (!broken0) {
				var f = instance_create_layer(0, Level.tilePos(8), "Fakewalls", Fakewall);
				f.sprite = sFakewall1;
				f.onDestroy = function() {
					SaveState.progression.cave_entrance.hidden_wall_0.isBroken = true;
				}
			}
		},
	});
	
	LEVEL.Register(rmLevel_Cave_Hidden_1, {
		name : "Cave's Mysterious Portal",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("right", 0, 0, rmLevel_Cave_Entrance),
		],
	});
	
	LEVEL.Register(rmLevel_Cave_Corridor0, {
		name : "Corridor",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("left", 0, 1, rmLevel_Cave_Entrance),
			TransitionSet("right", 1, 1, rmLevel_Cave_Elevator),
			TransitionSet("down", 1, 2, rmLevel_Cave_Junkyard, new Vec2(2, 2)),
		],
	});
	
	LEVEL.Register(rmLevel_Cave_Elevator, {
		name : "Elevator",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("left", 0, 1, rmLevel_Cave_Corridor0),
		],
	});
	
	LEVEL.Register(rmLevel_Cave_SpikeCorridor, {
		name : "Palace Entrance",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("right", 2, 0, rmLevel_Cave_SaveRoom),
			TransitionSet("left", 0, 0, rmLevel_Cave_Village, new Vec2(0, 9)),
			TransitionSet("down", 0, 1, rmLevel_Cave_Entrance),
		],
	});
	
	LEVEL.Register(rmLevel_Cave_Village, {
		name : "Village",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("right", 3, 0, rmLevel_Cave_SpikeCorridor),
		],
		
		
		roomCode : function() {
			parallax_set("Parallax_1", 0.5);
			parallax_set("Parallax_2", 0.6);
			parallax_set("Parallax_3", 0.7);
			
			parallax_set("Rocks_1", 0.1, 0.025);
			parallax_set("Rocks_2", 0.2, 0.05);
		}
	});
	
	LEVEL.Register(rmLevel_Cave_Junkyard, {
		name : "Dump Yard",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
		],
		
		load : function() {
			// Boss code
			if (!SaveState.progression.dump_yard.boss_0.defeated) {
				// Create boss entrance cutscene
				instance_create_depth(0, 0, 0, Cutscene_Junkeeper);
			}
		},
		
		roomCode : function() {
			
			parallax_set("Towers_1", 0);
			parallax_set("Towers_2", 0.1);
			parallax_set("Towers_3", 0.2);
			parallax_set("Towers_4", 0.3);
			parallax_set("Towers_5", 0.5);
			
		}
	});
	
	LEVEL.Register(rmLevel_Cave_SaveRoom, {
		name : "Save Room",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
			TransitionSet("left", 0, 0, rmLevel_Cave_SpikeCorridor)
		],
		
		load : function() {
		},
		
		roomCode : function() {
		}
	});
	
	#endregion
	
	
	#region GARDEN
	
	LEVEL.Register(rmLevel_Garden_Entrance, {
		name : "Garden Entrance",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
		],
	});
	
	LEVEL.Register(rmLevel_Skartobreke, {
		name : "Skartobreke",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
		],
	});
	
	
	#endregion
	
}






