function macros_load(){
	
	#macro FORCE_DECELERATION 0.1
	#macro MAX_FALLING_SPEED 2.8
	
	#macro WIDTH display_get_gui_width()
	#macro HEIGHT display_get_gui_height()
	
	#macro CAMERA_ZOOM_DEFAULT 1
	#macro CAMERA_VIEWPORT_DEFAULT 0
	
	#macro DEFAULT_FONT fnt_console
	
	// Player
	#macro PLAYER_COMMAND_INPUT_TIMER 15
	#macro PLAYER_BUFFER_ROOM_WIDTH 1
	
	#macro ROOM_TILE_WIDTH 360
	#macro ROOM_TILE_HEIGHT 180
	
	// save files
	#macro SAVEFILE_SETTINGS "settings.hh"
	#macro SAVEFILE_CHAPTERS "story.hh"
	
	
	// existing functions
	#macro print show_debug_message
	#macro quit game_end
	
}