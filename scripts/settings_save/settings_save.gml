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
	
	var names = struct_get_names(content);
	
	for (var i = 0; i < array_length(names); i++) {
		struct_set(Settings, names[i], struct_get(content, names[i]));
	}
	
	
	show_debug_message("Settings Loaded!");
	
}
