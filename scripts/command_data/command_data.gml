
function command_data(){

globalvar CommandData;
CommandData = [];

var command = function(name, argc, fn) {
	return {
		name: name,
		argc: argc,
		fn: fn,
	}
}

var add = function(val) {
	array_push(CommandData, val);
}

add(command("start", 0, function(args) {
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
}));

add(command("exit", 0, function(args) {
	game_end();
}));

add(command("kitty", 0, function(args) {
	log("Joana - tuxedo");
	log("Neve - white lioness");
	log("Nina - the judge");
}));

add(command("credits", 0, function(args) {
	log("Programming by Andrei Scatolin", c_aqua);
	log("Art by Andrei Scatolin", c_aqua);
	log("Audio Design by Andrei Scatolin", c_aqua);
	log("-------------------------------", c_red);
	log("Special Thanks to", c_yellow);
	log(" - Gabriel", $D851E0, fnt_console_bold);
	log(" - João", c_red, fnt_console_bold);
	log(" - Yury", c_green, fnt_console_bold);
}));

add(command("fps", 0, function(args) {
	log("fps: " + string(fps));
}));

add(command("clear", 0, function(args) {
	logs = [];
}));

add(command("item", 1, function(args) {
	
	var itemID = real(args[0]);
	if (!ds_map_exists(ItemData, itemID)) {
		log("Non-existing itemID");
		return false;
	}
	
	var item = instance_create_depth(Player.x, Player.y - 8, depth, Item);
	item.itemID = itemID;
	
	log($"Spawned {item_get(itemID).name}.");
	
}));

add(command("spawn", 3, function(args) {
	var obj = asset_get_index(args[0]);
	
	if (obj == -1) {
		log($"'{args[0]}' doesn't exist.");
		return false;
	}
	
	var xx, yy;
	
	if (string_starts_with(args[1], "~")) {
		var xpos = real(string_delete(args[1], 0, 1));
		xx = Player.x + xpos;
	} else {
		xx = real(args[1]);
	}
	
	if (string_starts_with(args[2], "~")) {
		var ypos = real(string_delete(args[2], 0, 1));
		yy = Player.y + ypos;
	} else {
		yy = real(args[2]);
	}
	
	instance_create_layer(xx, yy, "Instances", obj);
}));

add(command("settings", 0, function(args) {
	log(json_stringify(Settings, true));
}));

}

