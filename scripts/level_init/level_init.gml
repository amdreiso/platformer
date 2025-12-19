
//function level_init(){
	
//	globalvar LevelData; LevelData = ds_map_create();
//	globalvar LEVEL;
	
//	LEVEL = {
//		transitionAdd: function(side, x, y, roomID, playerOffset=new Vec2(), isHidden = false) {
//			var t = {};
			
//			t.side = side;
//			t.x = x * ROOM_TILE_WIDTH;
//			t.y = y * ROOM_TILE_HEIGHT;
//			t.roomID = roomID;
//			t.playerOffset = playerOffset;
//			t.isHidden = isHidden;
			
//			return t;
//		},
		
//		getDefaultComponents: function() {
//			return {
//				backgroundSong: -1,
//				darkness: 0,
//				playerVision: 1,
//				isCutscene: false,
//				create: function(){},
//				roomCode: function(){},
//				transitions: [],
//				section: LEVEL_SECTION.Caves,
				
//				mapOffsetPos: new Vec2(),
//				mapTileColor: c_aqua,
//			};
//		},
		
//		register: function(levelID, name, components = {}) {
//			var level = {};
//			level.name = name;
//			level.components = LEVEL.getDefaultComponents();
			
//			struct_merge(level.components, components);
			
//			LevelData[? levelID] = level;
//		},
		
//		get: function(levelID) {
//			return (LevelData[? levelID] ?? undefined);
//		}
		
//	};
	
	
//	// Initializing 
//	LEVEL.register(rmTEST, "TESTING ROOM", {
//		darkness: 0.00,
//	});
	
	
//	LEVEL.register(rmBegginingCutscene, "beggining cutscene", {
//		darkness: 0.00,
//		isCutscene: true,
		
//		backgroundSong: snd_mechanicalHope,
		
//	});
	
	
//	#region Caves
	
//	var caveBackgroundSong = -1;
	
//	LEVEL.register(rmLevel_Cave_Entrance, "cave entrance", {
//		darkness: 0.00,
		
//		backgroundSong: caveBackgroundSong,
		
//		transitions: [
//			LEVEL.transitionAdd("up", 0, 0, rmLevel_Cave_SpikeCorridor),
//			LEVEL.transitionAdd("left", 0, 0, rmLevel_Cave_Hidden_1, new Vec2(), true),
//			LEVEL.transitionAdd("right", 2, 1, rmLevel_Cave_Corridor0),
//		],
		
//		roomCode: function() {
//			parallax_set("Parallax_1", 0.20, -1);
//			parallax_set("Tiles_1", 0.25, -1);
//			parallax_set("Tiles_2", 0.50, 0.20);
//			parallax_set("Tiles_3", 0.80, 0.20);
//		},
		
//		create: function() {
//			var broken0 = CurrentChapter.cave_entrance.hidden_wall_0.isBroken;
			
//			if (!broken0) {
//				var f = instance_create_layer(0, Level.tilePos(8), "Fakewalls", FakeWall);
//				f.sprite = sFakewall1;
//				f.onDestroy = function() {
//					CurrentChapter.cave_entrance.hidden_wall_0.isBroken = true;
//					STORY.save();
//				}
//			}
//		},
//	});
	
//	LEVEL.register(rmLevel_Cave_Village, "village", {
//		darkness: 0.00,
		
//		backgroundSong: snd_dreamsOfAnElectricMind,
		
//		roomCode: function() {
//			parallax_set("Parallax_1", 0.20, -1);
//			parallax_set("Parallax_2", 0.50, -1);
//			parallax_set("Parallax_3", 0.80, -1);
//		}
//	});
	
//	LEVEL.register(rmLevel_Cave_DumpYard, "dump yard", {
//		darkness: 0.00,
//		playerVision: 0.33,
		
//		backgroundSong: snd_forgottenSpace,
		
//		mapOffsetPos: new Vec2(3, 3),
//		mapTileColor: c_red,
		
//		transition: [
//			LEVEL.transitionAdd("up", 0, 0, rmLevel_Cave_DumpYard, new Vec2(-1, 0)),
//		],
		
//		create: function() {
//			// Boss code
//			if (!CurrentChapter.dump_yard.boss_0.defeated) {
//				// Create boss entrance cutscene
//				instance_create_depth(0, 0, 0, Cutscene_Junkeeper);
//			}
			
//		}
//	});
	
//	LEVEL.register(rmLevel_Cave_Hidden_1, "hidden 1", {
//		darkness: 0.00,
//		playerVision: 0.33,
		
//		backgroundSong: caveBackgroundSong,
		
//		mapOffsetPos: new Vec2(-1, 0),
		
//		transitions: [
//			LEVEL.transitionAdd("right", 0, 0, rmLevel_Cave_Entrance),
//		],
//	});
	
//	LEVEL.register(rmLevel_Cave_SpikeCorridor, "cave corridor", {
//		darkness: 0.00,
//		playerVision: 0.33,
		
//		backgroundSong: caveBackgroundSong,
		
//		mapOffsetPos: new Vec2(0, -1),
		
//		transitions: [
//			LEVEL.transitionAdd("down", 0, 1, rmLevel_Cave_Entrance),
//		],
//	});
	
//	LEVEL.register(rmLevel_Cave_Corridor0, "corridor", {
//		darkness: 0.00,
//		playerVision: 0.33,
		
//		backgroundSong: caveBackgroundSong,
		
//		mapOffsetPos: new Vec2(3, 0),
		
//		transitions: [
//			LEVEL.transitionAdd("left", 0, 1, rmLevel_Cave_Entrance),
//			LEVEL.transitionAdd("right", 1, 1, rmLevel_Cave_Elevator),
//			LEVEL.transitionAdd("down", 1, 2, rmLevel_Cave_DumpYard, new Vec2(2, 2)),
//		],
//	});
	
//	LEVEL.register(rmLevel_Garden_Entrance, "garden entrance", {
		
//		roomCode: function() {
//			parallax_set("Tiles_3", 0.50, -1);
//			parallax_set("Tiles_4", 0.65, -1);
//		}
		
//	});
	
//	LEVEL.register(rmLevel_Cave_Elevator, "Cave Elevator", {
		
//		backgroundSong: caveBackgroundSong,
		
//		transitions: [
//			LEVEL.transitionAdd("left", 0, 1, rmLevel_Cave_Corridor0),
//		],
		
//	});
	
//	#endregion
	
	
//	#region Secret Rooms
	
	
//	LEVEL.register(rmLevel_Skartobreke, "skartobreke", {
//	});
	
//	#endregion
	
//}


function level_init() {
	
	globalvar LEVEL;
	
	var defaultComponents = function() {
		return {
			name: "",
			dimension: DIMENSION_ID.Main,
			
			backgroundSong: -1,
			darkness: 0,
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
	var TransitionSet = function(side, x, y, roomID, playerOffset=new Vec2(), isHidden = false) {
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
			TransitionSet("left", 0, 0, rmLevel_Cave_Hidden_1, new Vec2(), true),
			TransitionSet("right", 2, 1, rmLevel_Cave_Corridor0),
		],
		
		load: function() {
			
			// Spawn Fakewall if not broken
			var broken0 = CurrentChapter.cave_entrance.hidden_wall_0.isBroken;
			
			if (!broken0) {
				var f = instance_create_layer(0, Level.tilePos(8), "Fakewalls", Fakewall);
				f.sprite = sFakewall1;
				f.onDestroy = function() {
					CurrentChapter.cave_entrance.hidden_wall_0.isBroken = true;
					STORY.save();
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
			TransitionSet("down", 1, 2, rmLevel_Cave_DumpYard, new Vec2(2, 2)),
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
			TransitionSet("down", 0, 1, rmLevel_Cave_Entrance),
		],
	});
	
	LEVEL.Register(rmLevel_Cave_DumpYard, {
		name : "Dump Yard",
		dimension : DIMENSION_ID.Main,
		
		transitions : [
		],
		
		load : function() {
			// Boss code
			if (!CurrentChapter.dump_yard.boss_0.defeated) {
				// Create boss entrance cutscene
				instance_create_depth(0, 0, 0, Cutscene_Junkeeper);
			}
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
	
	
	#endregion
	
}






