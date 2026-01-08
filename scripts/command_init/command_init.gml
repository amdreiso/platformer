
function command_init(){

globalvar CommandData;
CommandData = [];

globalvar COMMAND;
COMMAND = {
	register: function(name, argc, fn){
		var command = {};
		command.name = name;
		command.argc = argc;
		command.fn = fn;
		array_push(CommandData, command);
	},
}

COMMAND.register("save_settings", 0, function(args){
	settings_save();
});

COMMAND.register("set_gravity", 1, function(args){
	var value = real(args[0]);
	Gravity = value;
});

COMMAND.register("start", 0, function(args) {
	log("	     .->    (`-')  _                             <-. (`-')   (`-')  _    (`-')               ", make_color_hsv(0, 255, 255));
	log(" (`(`-')/`) ( OO).-/  <-.    _             .->      \\(OO )_  ( OO).-/    ( OO).->       .->   ", make_color_hsv(16, 255, 255));
	log(",-`( OO).',(,------.,--. )   \\-,-----.(`-')----. ,--./  ,-.)(,------.    /    '._  (`-')----. ", make_color_hsv(32, 255, 255));
	log("|  |\\  |  | |  .---'|  (`-')  |  .--./( OO).-.  '|   `.'   | |  .---'    |'--...__)( OO).-.  '", make_color_hsv(48, 255, 255));
	log("|  | '.|  |(|  '--. |  |OO ) /_) (`-')( _) | |  ||  |'.'|  |(|  '--.     `--.  .--'( _) | |  |", make_color_hsv(64, 255, 255));
	log("|  |.'.|  | |  .--'(|  '__ | ||  |OO ) \\|  |)|  ||  |   |  | |  .--'        |  |    \\|  |)|  |", make_color_hsv(80, 255, 255));
	log("|   ,'.   | |  `---.|     |'(_'  '--'\\  '  '-'  '|  |   |  | |  `---.       |  |     '  '-'  '", make_color_hsv(96, 255, 255));
	log("`--'   '--' `------'`-----'    `-----'   `-----' `--'   `--' `------'       `--'      `-----' ", make_color_hsv(112, 255, 255));
	log("                                 <-. (`-')_  (`-').->                    (`-')  _             ", make_color_hsv(128, 255, 255), fnt_console_bold);
	log("             _             .->      \\( OO) ) ( OO)_      .->      <-.    ( OO).-/             ", make_color_hsv(144, 255, 255), fnt_console_bold);
	log("             \\-,-----.(`-')----. ,--./ ,--/ (_)--\\_)(`-')----.  ,--. )  (,------.             ", make_color_hsv(160, 255, 255), fnt_console_bold);
	log("              |  .--./( OO).-.  '|   \\ |  | /    _ /( OO).-.  ' |  (`-') |  .---'             ", make_color_hsv(176, 255, 255), fnt_console_bold);
	log("             /_) (`-')( _) | |  ||  . '|  |)\\_..`--.( _) | |  | |  |OO )(|  '--.              ", make_color_hsv(192, 255, 255), fnt_console_bold);
	log("             ||  |OO ) \\|  |)|  ||  |\\    | .-._)   \\\\|  |)|  |(|  '__ | |  .--'              ", make_color_hsv(208, 255, 255), fnt_console_bold);
	log("            (_'  '--'\\  '  '-'  '|  | \\   | \\       / '  '-'  ' |     |' |  `---.             ", make_color_hsv(224, 255, 255), fnt_console_bold);
	log("               `-----'   `-----' `--'  `--'  `-----'   `-----'  `-----'  `------'             ", make_color_hsv(240, 255, 255), fnt_console_bold);
	log("");
	log("");
	log("ascii art from: https://patorjk.com/software/taag/", c_gray);
	log("");
	log("");
});

COMMAND.register("exit", 0, function(args) {
	game_end();
});

COMMAND.register("credits", 0, function(args) {
	log("-------------------------------", c_red);
	log("Programming by Andrei Scatolin", c_aqua);
	log("Art by Andrei Scatolin", c_aqua);
	log("Audio Design by Andrei Scatolin", c_aqua);
	log("-------------------------------", c_red);
});

COMMAND.register("restart", 0, function(args) {
	game_restart();
});

COMMAND.register("help", 0, function(args) {
	var len = array_length(CommandData);
	var columns = 4;
	var rows = ceil(len / columns);
	
	for (var i=0; i<rows; i++) {
		var str = "";
		
		for (var j=0; j<columns; j++) {
			var index = j * rows + i;
			if (index < len) {
				str += string_pad(CommandData[index].name, 20);
			}
		}
		
		log(str);
	}
});

COMMAND.register("clear", 0, function(args) {
	CONSOLE.Clear();
});

COMMAND.register("spawn", 3, function(args) {
	var enemy = args[0];
	var x0 = real(args[1]) ?? 0;
	var y0 = real(args[2]) ?? 0;
	
	var obj = asset_get_index(enemy);
	
	if (!object_exists(obj)) {
		err("Object doesn't exist");
		return;
	};
	
	instance_create_depth(Player.x + x0, Player.y + y0, Player.depth, obj);
});

COMMAND.register("goto", 1, function(args) {
	var rm = args[0];
	var asset = asset_get_index(rm);
	
	if (!room_exists(asset)) {
		err("Room doesn't exist");
		return;
	};
	
	room_goto(asset);
});

COMMAND.register("zoom", 1, function(args) {
	camera_set_zoom(real(args[0]));
});

COMMAND.register("test", 0, function(args) {
	room_goto(rmTEST);
	Debug.debug = true;
	player_set_position(new Vec2(160, 138));
});

COMMAND.register("debug_combo", 0, function(args) {
	Debug.drawAttackCommandInput = !Debug.drawAttackCommandInput;
});

COMMAND.register("game_speed", 1, function(args) {
	var val = real(args[0]);
	GameSpeed = val;
});

COMMAND.register("instance_value", 2, function(args) {
	var obj = asset_get_index(args[0]);
	if (!instance_exists(obj)) {
		err($"There are no instances of {object_get_name(obj)} on this level");
		return;
	}
	var value = args[1];
	
	var r = variable_instance_get(obj, value);
	
	if (is_struct(r)) {
		r = json_stringify(r, true);
	}
	
	log(r);
});

COMMAND.register("webhook", -1, function(args) {
	//var url = "https://discord.com/api/webhooks/1433176484146708591/fursMfR_WUCBm5pSHTCRJPWtuB9NG_XuJhmdC9U5UDrUABbVjc__UheBwiSWQ7iSIl5t";
	var url = "https://discord.com/api/webhooks/1433189295535165627/ieUi2nhy9YHKo05PpUcTayQUqpbq5c-ee75sanZrTH2DRajJibgBRq7dYN-to0TTJTTd";
	var msg = "";
	
	for (var i = 0; i < array_length(args); i++) {
		msg += args[i] + " ";
	}
	
	var json = json_stringify({content: msg});
	
	var headers = ds_map_create();
	ds_map_add(headers, "Content-Type", "application/json");
	
	http_request(url, "POST", headers, json);
	
});

COMMAND.register("run", -1, function(args) {
	str = "";
	for (var i = 0; i < array_length(args); i++) {
		str += args[i] + " ";
		
	}
	
	Main.callback.Register(function(obj){
		Main.runCommand(str);
		
	});
});

COMMAND.register("christmas", 0, function(args) {
	Occasion.christmas = !Occasion.christmas;
});

COMMAND.register("easter", 0, function(args) {
	Occasion.easter = !Occasion.easter;
});

COMMAND.register("halloween", 0, function(args) {
	Occasion.halloween = !Occasion.halloween;
});

COMMAND.register("language", 1, function(args) {
	var val = real(args[0]);
	language_set(val);
});

}


