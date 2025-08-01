
function command_init(){

globalvar CommandData;
CommandData = [];



var add = function(name, argc, fn) {
	var command = function(name, argc, fn) {
		return {
			name: name,
			argc: argc,
			fn: fn,
		}
	}
	
	array_push(CommandData, command(name, argc, fn));
}

add("start", 0, function(args) {
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

add("exit", 0, function(args) {
	game_end();
});

add("credits", 0, function(args) {
	log("-------------------------------", c_red);
	log("Programming by Andrei Scatolin", c_aqua);
	log("Art by Andrei Scatolin", c_aqua);
	log("Audio Design by Andrei Scatolin", c_aqua);
	log("-------------------------------", c_red);
});

add("restart", 0, function(args) {
	game_restart();
});

add("help", 0, function(args) {
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

add("clear", 0, function(args) {
	Main.clearConsole();
});


}


