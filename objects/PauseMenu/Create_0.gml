
//backgroundSong = audio_play_sound(snd_menu, 0, true, 1, 0, random_range(0.90, 1.00));

enum MENU_PAGE {
	Resume,
	Home,
	Dev,
	Options,
	OptionsAudio,
	OptionsGraphics,
}

page = MENU_PAGE.Home;
menuBackgroundColor = c_black;

c1 = c_black;
c2 = c_black;
c3 = c_black;
c4 = c_black;
margin = 5;

test = 0;

menuButtonForeground = Style.GUI.light.buttonForeground;
menuButtonBackground = Style.GUI.light.buttonBackground;

enum MENU_BUTTON_TYPE {
	Method,
	Slider,
}

var Button = function(name, backgroundColor, textColor, fn, goback = true) {
	return {
		type: MENU_BUTTON_TYPE.Method,
		name: name,
		fn: fn,
		backgroundColor: backgroundColor,
		textColor: textColor,
		goback: goback,
	}
}

var ButtonSlider = function(name, backgroundColor, textColor, get, set, variabledefault, slope=0.1) {
	return {
		type: MENU_BUTTON_TYPE.Slider,
		name: name,
		backgroundColor: backgroundColor,
		textColor: textColor,
		get: get,
		set: set,
		variabledefault: variabledefault,
		slope: slope,
	}
}

homeButtons = [
	Button("resume", c_white, c_black, function(){
		instance_destroy(PauseMenu);
	}),
	
	Button("options", c_green, c_black, function(){
		PauseMenu.page = MENU_PAGE.Options;
	}),
	
	Button("feed the dev xD", c_red, c_black, function(){
		PauseMenu.page = MENU_PAGE.Dev;
	}),
	
	Button("quit", c_orange, c_blue, function(){
		game_end();
	}),
];

optionButtons = [
	Button("return", c_blue, c_white, function(){
		PauseMenu.page = MENU_PAGE.Home;
	}),
	
	Button("graphics", c_fuchsia, c_black, function(){
		PauseMenu.page = MENU_PAGE.OptionsGraphics;
	}),	
	
	Button("audio", c_aqua, c_black, function(){
		PauseMenu.page = MENU_PAGE.OptionsAudio;
	}),	
];

optionGraphicButtons = [
	Button("return", c_blue, c_white, function(){
		PauseMenu.page = MENU_PAGE.Options;
	}),
	
	Button("toggle fullscreen", make_color_rgb(35, 35, 35), c_white, function(){
		window_set_fullscreen( !window_get_fullscreen() );
	}),
];

optionAudioButtons = [
	Button("return", c_blue, c_white, function(){
		PauseMenu.page = MENU_PAGE.Options;
	}),
	
	ButtonSlider("volume", $FFCBA646, c_black, 
							function(){ return Settings.audio.volume; },
							function(v){ Settings.audio.volume = clamp(v, 0, 1); save_settings(); },
							1.00, 0.005),
	
	ButtonSlider("music", make_color_rgb(200, 200, 80), c_black, 
							function(){ return Settings.audio.music; },
							function(v){ Settings.audio.music = clamp(v, 0, 1); save_settings(); },
							1.00, 0.005),
	
	ButtonSlider("sfx", make_color_rgb(170, 130, 220), c_black, 
							function(){ return Settings.audio.sfx; },
							function(v){ Settings.audio.sfx = clamp(v, 0, 1); save_settings(); },
							1.00, 0.005),
];

devButtons = [
	Button("return", c_blue, c_white, function(){
		PauseMenu.page = MENU_PAGE.Home;
	}),
	
	Button("discord", make_color_rgb(100, 100, 255), c_white, function(){
		url_open("https://discord.gg/hkfcYf8pDS");
	}),
	
	Button("youtube", make_color_rgb(255, 55, 205), c_black, function(){
	}),
	
	Button("ko-fi", make_color_rgb(100, 10, 155), c_white, function(){
	}),
	
	Button("instagram", make_color_rgb(84, 200, 55), c_black, function(){
	}),
	
	Button("patreon", make_color_rgb(100, 80, 05), c_white, function(){
	}),
];

buttonIndex = 0;

drawButtons = function(arr) {
	var click = (Keymap.select);
	var up		= (Keymap.selectUp);
	var down  = (Keymap.selectDown);
	var left  = (Keymap.selectLeft);
	var right = (Keymap.selectRight);
	
	for (var i = 0; i < array_length(arr); i++) {
		var b = arr[i];
		var str = b.name;
		var height = 32;
				
		if (buttonIndex == i) {
			str = string_insert("[ ", str, 0);
			str = string_insert(str, " ]", 0);
		}
		
		var heightOffset = 2;
		
		switch (b.type) {
			case MENU_BUTTON_TYPE.Method:
			
				draw_label(
					margin, (margin) + (i + heightOffset) * height, str, 1, 
					menuButtonBackground, menuButtonForeground, 1
				);
				
				break;
				
			case MENU_BUTTON_TYPE.Slider:
				
				var maxwidth									= 100;
				var current										= b.get();
				var step											= (current / b.variabledefault);
				var width											= maxwidth * step;
				var arrowButtonWidth					= 20;
				
				var leftArrowBackgroundColor	= menuButtonBackground;
				var leftArrowTextColor				= menuButtonForeground;
				
				var rightArrowBackgroundColor = menuButtonBackground;
				var rightArrowTextColor				= menuButtonForeground;
				
				if (buttonIndex == i) {
					if (left && current > 0) { 
						leftArrowBackgroundColor = menuButtonForeground;
						leftArrowTextColor = menuButtonBackground;
						
						b.set(current - b.slope); 
					}
					
					if (right && current < b.variabledefault) { 
						rightArrowBackgroundColor = menuButtonForeground;
						rightArrowTextColor = menuButtonBackground;
						
						b.set(current + b.slope); 
					}
				}
				
				draw_label_width(
					margin, margin + (i + heightOffset) * height,
					"<", arrowButtonWidth, arrowButtonWidth, 1, leftArrowBackgroundColor, leftArrowTextColor, 1
				);
				
				draw_label_width(
					margin + arrowButtonWidth, margin + (i + heightOffset) * height, str, width, maxwidth, 1, 
					b.textColor, b.backgroundColor, 1, true, 4, false
				);
				
				draw_label_width(
					margin + arrowButtonWidth, margin + (i + heightOffset) * height, str, width, maxwidth, 1, 
					b.backgroundColor, b.textColor, 1, true
				);
				
				draw_label_width(
					(margin + arrowButtonWidth) + maxwidth, margin + (i + heightOffset) * height,
					">", arrowButtonWidth, arrowButtonWidth, 1, rightArrowBackgroundColor, rightArrowTextColor, 1
				);
				
				break;
		}
	}
	
	if (Debug.console) return;
	
	if (click && arr[buttonIndex].type == MENU_BUTTON_TYPE.Method) {
		arr[buttonIndex].fn();
		if (arr[buttonIndex].goback) buttonIndex = 0;
	}
			
	if (up && buttonIndex > 0) {
		buttonIndex --;
		//audio_stop_sound(snd_select_menu);
		//audio_play_sound(snd_select_menu, 0, false, 1, 0, random_range(0.87, 1.00));
	};
	
	if (down && buttonIndex < array_length(arr) - 1) {
		buttonIndex ++;
		//audio_stop_sound(snd_select_menu);
		//audio_play_sound(snd_select_menu, 0, false, 1, 0, random_range(0.87, 1.00));
	};
}

drawMenu = function() {
	switch(page) {
		case MENU_PAGE.Home:
			drawButtons(homeButtons);
			break;
		
		case MENU_PAGE.Options:
			drawButtons(optionButtons);
			break;
		
		case MENU_PAGE.OptionsAudio:
			drawButtons(optionAudioButtons);
			break;
		
		case MENU_PAGE.OptionsGraphics:
			drawButtons(optionGraphicButtons);
			break;
		
		case MENU_PAGE.Dev:
			drawButtons(devButtons);
			break;
	}
}




