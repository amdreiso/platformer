
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
	var columns = 3;
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
	Main.clearConsole();
});

COMMAND.register("spawn", 3, function(args) {
	var enemy = args[0];
	var x0 = real(args[1]);
	var y0 = real(args[2]);
	
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
	player_set_position(vec2(160, 138));
});



}


