
function SaveSystem() constructor {
	
	/**
	 * Saves current state of the game
	 */
	static Save = function() {
		var content = json_stringify(SaveState);
		var buffer = buffer_create(string_byte_length(content) + 1, buffer_grow, 1);
		buffer_write(buffer, buffer_string, content);
		buffer_save(buffer, SAVE_FILE);
		buffer_delete(buffer);
		
		print("SaveSystem: saved");
	}
	
	/**
	 * Loads save state of the game to global variable 'SaveState'
	 */
	static Load = function() {
		if (!file_exists(SAVE_FILE)) return;
			
		var buffer = buffer_load(SAVE_FILE);
		var str = buffer_read(buffer, buffer_string);
		var content = json_parse(str);
		buffer_delete(buffer);
		
		try {
			struct_merge_recursive(SaveState.progression, content.progression);
		} catch (e) {
			print(e);
		}
		
		try {
			struct_merge_recursive(SaveState.player, content.player);
		} catch (e) {
			print(e);
		}
		
		print("SaveSystem: loaded");
	}
	
	/**
	 * Restores save state to its default state
	 */
	static Restore = function() {
		self.GetDefaultSaveState();
		SaveManager.Save();
	}
	
	/**
	 * Resets SaveState to an unmodified, clean save state
	 */
	static GetDefaultSaveState = function() {
		var player = {
			level: -1,
			pos: new Vec2(),
			xscale: 1,
			
			/*
				TODO: save inventory, save gold, save modules
			*/
		};
		
		var progression = {
			beggining_cutscene: {
				played: true,
			},
		
			cave_entrance: {
				hidden_wall_0: {
					isBroken: false,
				},
			},
		
			dump_yard: {
				boss_0: {
					defeated: false,
				}
			},
		}
		
		SaveState.player = player;
		SaveState.progression = progression;
	}
	
	static SavePlayer = function(x, y) {
		if (!instance_exists(Player)) return;
		
		SaveState.player.level = room;
		SaveState.player.pos = new Vec2(x, y);
		SaveState.player.xscale = Player.image_xscale;
	}
}

function save_manager(){
	
	globalvar SaveManager;
	globalvar SaveState; SaveState = {};
	
	SaveManager = new SaveSystem();
	
	// Set fresh save
	SaveManager.GetDefaultSaveState();
	
	// Load any save files
	SaveManager.Load();
	
}





