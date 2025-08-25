function macros_load(){
	
	#macro FORCE_DECELERATION 0.1
	#macro MAX_FALLING_SPEED 2.8
	
	#macro WIDTH display_get_gui_width()
	#macro HEIGHT display_get_gui_height()
	
	#macro CAMERA_ZOOM_DEFAULT 1
	
	
	// Player
	#macro PLAYER_COMMAND_INPUT_TIMER 15
	
	
	// save files
	#macro SAVEFILE_SETTINGS "settings.json"
	#macro SAVEFILE_CHAPTERS "story.json"
	
	
	// existing functions
	#macro print show_debug_message
	#macro quit game_end
	
}