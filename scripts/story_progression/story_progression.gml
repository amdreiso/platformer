function story_progression(){
	
	globalvar STORY; STORY = {};
	globalvar CurrentChapter;
	
	STORY = {
		save: function() {
			
		},
		
		load: function() {
		},
		
		getProgression: function() {
		}
	};
	
	var chapter0 = {
		cave_entrance: {
			robot_0: {
				isFixed: false,
			},
			
			cutscene_0: {
				played: false,
			}
		}
	}
	
	STORY.chapter0 = chapter0;
	
	CurrentChapter = STORY.chapter0;
}