function story_progression(){
	
	globalvar STORY; STORY = {};
	globalvar CHAPTERS; CHAPTERS = {};
	globalvar CurrentChapter;
	
	STORY = {
		save: function() {
			var content = json_stringify(CHAPTERS);
			var buffer = buffer_create(string_byte_length(content) + 1, buffer_grow, 1);
			buffer_write(buffer, buffer_string, content);
			buffer_save(buffer, SAVEFILE_CHAPTERS);
			buffer_delete(buffer);
		},
		
		load: function() {
			if (!file_exists(SAVEFILE_CHAPTERS)) return;
			
			var buffer = buffer_load(SAVEFILE_CHAPTERS);
			var str = buffer_read(buffer, buffer_string);
			var content = json_parse(str);
			buffer_delete(buffer);
			CHAPTERS = content;
		},
		
		getProgression: function() {
		}
	};
	
	var chapter0 = {
		beggining_cutscene: {
			played: true,
		},
		
		cave_entrance: {
			hidden_wall_0: {
				isBroken: false,
			},
			
			robot_0: {
				isFixed: false,
			},
			
			cutscene_0: {
				played: false,
			}
		},
		
		dump_yard: {
			boss_0: {
				defeated: false,
			}
		},
	}
	
	CHAPTERS.chapter0 = chapter0;
	
	CurrentChapter = CHAPTERS.chapter0;
}