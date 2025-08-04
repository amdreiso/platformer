
function translation_init(){
	
	globalvar TranslationData; TranslationData = ds_map_create();
	globalvar TRANSLATION;
	
	TRANSLATION = {
		add: function(key) {
			token = ds_map_create();
			_key = key;
			
			methods = {};
			methods.set = function(languageID, str) {
				token[? languageID] = str;
				return methods;
			}
			
			methods.finalize = function() {
				TranslationData[? _key] = token;
			}
			
			return methods;
		},
		
		get: function(key) {
			return TranslationData[? key][? Language];
		},
	};
	
	#region GUI
	
	TRANSLATION.add("gui_quest_find")
		.set(LANGUAGE_ID.English, "find: ")
		.set(LANGUAGE_ID.Brazilian, "encontre: ")
		.finalize();
	
	#endregion
	
	#region Levels
	
	#region Caves
	
	TRANSLATION.add("cave_entrance_robot_examine_0")
		.set(LANGUAGE_ID.English, "it's broken.")
		.set(LANGUAGE_ID.Brazilian, "tá quebrado.")
		.finalize();
	
	
	TRANSLATION.add("cave_entrance_robot_fixed_0")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.add("cave_entrance_robot_fixed_1")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.add("cave_entrance_robot_fixed_2")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	
	TRANSLATION.add("cave_entrance_flowerstatue_0")
		.set(LANGUAGE_ID.English, "[italic]the statue holds a [color=#ffff0f]flower[/color][/italic]")
		.set(LANGUAGE_ID.Brazilian, "[italic]a estátua segura uma [color=#ffff0f]flor[/color][/italic]")
		.finalize();
	
	#endregion
	
	#endregion
	
}
