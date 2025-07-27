
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
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.add("cave_entrance_flowerstatue_1")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
}
