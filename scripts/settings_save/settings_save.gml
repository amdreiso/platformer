
function settings_get() {
	var settings = {
		graphics: {
			maxParticlesOnScreen: 200,
			cameraShakeIntensity: 1.0,
			guiScale: 2.0,
			raycastCount: 500,
			showKey: true,
		
			drawScanlines: false,
			drawUI: true,
		
			enableSurfaces: true,
		
			physics: {
				chains: false,
			},
		},
	
		audio: {
			volume: 1,
			music: 1,
			sfx: 1,
		},
	
		controls: {
			gamepadDeadzone: 0.25,
		},
	};
	
	settings.graphics.playerTrail = true;
	
	
	
	return settings;
}

function settings_save(){
	
	var con = json_stringify(Settings);
	var buffer = buffer_create(string_byte_length(con) + 1, buffer_grow, 1);
	buffer_write(buffer, buffer_string, con);
	buffer_save(buffer, SAVEFILE_SETTINGS);
	buffer_delete(buffer);
	
	show_debug_message("Settings Saved!");
	
}

function settings_load(){
	
	print(json_stringify(Settings, true));
	
	if (!file_exists(SAVEFILE_SETTINGS)) return;
	
	var buffer = buffer_load(SAVEFILE_SETTINGS);
	var content = json_parse(buffer_read(buffer, buffer_string));
	buffer_delete(buffer);
	
	struct_merge_recursive(Settings, content);
	
	show_debug_message("Settings Loaded!");
	
}
