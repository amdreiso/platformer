

enum MENU_PAGE {
	Resume,
	Home,
	Dev,
	Options,
	OptionsAudio,
	OptionsGraphics,
}

active = false;

page = MENU_PAGE.Home;
menuBackgroundColor = c_black;

c1 = c_black;
c2 = c_black;
c3 = c_black;
c4 = c_black;
margin = 5;
alpha = 0;

test = 0;

menuButtonForeground = Style.GUI.light.buttonForeground;
menuButtonBackground = Style.GUI.light.buttonBackground;

backgroundColor = c_blue;

setPage = function(val) {
	PauseMenu.buttonIndex = 0;
	PauseMenu.page = val;
}

enum MENU_BUTTON_TYPE {
	Method,
	Slider,
}

var Button = function(name, backgroundColor, textColor, fn, goback = false) {
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
		PauseMenu.active = false;
	}),
	
	Button("options", c_green, c_black, function(){
		setPage(MENU_PAGE.Options);
	}),
	
	Button("feed the dev xD", c_red, c_black, function(){
		setPage(MENU_PAGE.Dev);
	}),
	
	Button("quit", c_orange, c_blue, function(){
		game_end();
	}),
];

optionButtons = [
	Button("return", c_blue, c_white, function(){
		setPage(MENU_PAGE.Home);
	}),
	
	Button("graphics", c_fuchsia, c_black, function(){
		setPage(MENU_PAGE.OptionsGraphics);
	}),	
	
	Button("audio", c_aqua, c_black, function(){
		setPage(MENU_PAGE.OptionsAudio);
	}),	
];

optionGraphicButtons = [
	Button("return", c_blue, c_white, function(){
		setPage(MENU_PAGE.Options);
	}),
	
	Button("toggle scanlines", make_color_rgb(35, 35, 35), c_white, function(){
		Settings.graphics.drawScanlines = !Settings.graphics.drawScanlines;
	}),
];

optionAudioButtons = [
	Button("return", c_blue, c_white, function(){
		setPage(MENU_PAGE.Options);
	}),
	
	ButtonSlider("volume", $FFCBA646, Style.sliderBackground, 
							function(){ return Settings.audio.volume; },
							function(v){ Settings.audio.volume = clamp(v, 0, 1); settings_save(); },
							1.00, 0.005),
	
	ButtonSlider("music", make_color_rgb(200, 200, 80), Style.sliderBackground, 
							function(){ return Settings.audio.music; },
							function(v){ Settings.audio.music = clamp(v, 0, 1); settings_save(); },
							1.00, 0.005),
	
	ButtonSlider("sfx", make_color_rgb(170, 130, 220), Style.sliderBackground, 
							function(){ return Settings.audio.sfx; },
							function(v){ Settings.audio.sfx = clamp(v, 0, 1); settings_save(); },
							1.00, 0.005),
];

devButtons = [
	Button("return", c_blue, c_white, function(){
		setPage(MENU_PAGE.Home);
	}),
	
	Button("discord", make_color_rgb(100, 100, 255), c_white, function(){
		url_open("https://discord.gg/hkfcYf8pDS");
	}),
	
];

buttonIndex = 0;
menuWidth = 100;
menuHeight = HEIGHT;
menuPosX = -menuWidth * 3.5;
menuPosXFinal = menuWidth;
menuSelectedButtonAngle = 0;

drawButtons = function(arr) {
	if (!active) return;
	
	var click				= (Keymap.select);
	var up					= (Keymap.selectUp);
	var down				= (Keymap.selectDown);
	var left				= (Keymap.selectLeft);
	var right				= (Keymap.selectRight);
	var lefthold		= (Keymap.selectLeftHold);
	var righthold		= (Keymap.selectRightHold);
	
	var xx = menuPosX;
	var c0 = c_black;
	var scale = 0.75;
	
	var buttonPadding = 1.25;

	for (var i = 0; i < array_length(arr); i++) {
		var b = arr[i];
		var str = b.name;
		var height = string_height(str) * buttonPadding * scale;
		
		var back = menuButtonBackground;
		var fore = menuButtonForeground;
		
		if (buttonIndex == i) {
			str = string_insert("> ", str, 0);
			str = string_insert(str, " <", 0);
		} else {
			back = color_darkness(back, 50);
		}
		
		var heightOffset = 2;
		
		var buttonPosX = xx;
		
		switch (b.type) {
			case MENU_BUTTON_TYPE.Method:
			
				draw_label(
					(buttonPosX), (margin) + (i + heightOffset) * height, str, scale, 
					back, fore, 1
				);
				
				break;
				
			case MENU_BUTTON_TYPE.Slider:
				
				var maxwidth									= 100;
				var current										= b.get();
				var step											= (current / b.variabledefault);
				var width											= maxwidth * step;
				var arrowButtonWidth					= 20;
				var color											= c_black;
				var alpha											= 1;
				
				var leftArrowBackgroundColor	= back;
				var leftArrowTextColor				= fore;
				
				var rightArrowBackgroundColor = back;
				var rightArrowTextColor				= fore;
				
				if (buttonIndex == i) {
					if (lefthold && current > 0) { 
						leftArrowBackgroundColor = fore;
						leftArrowTextColor = back;
						
						b.set(current - b.slope); 
					}
					
					if (righthold && current < b.variabledefault) { 
						rightArrowBackgroundColor = fore;
						rightArrowTextColor = back;
						
						b.set(current + b.slope); 
					}
				}
				
				if (width < 50) {
					color = c_white;
				}
				
				var x0 = buttonPosX;
				
				//// Labels
				//draw_label_width(
				//	(x0 - maxwidth / 2), margin + (i + heightOffset) * height, " ", maxwidth, maxwidth, scale, 
				//	b.textColor, b.backgroundColor, 1, true, 4, false
				//);
				
				//draw_label_width(
				//	(x0 - width / 2), margin + (i + heightOffset) * height, " ", width, maxwidth, scale, 
				//	b.backgroundColor, b.textColor, 1, true
				//);
				
				
				
				// Left Button
				draw_label_width(
					buttonPosX,
					margin + (i + heightOffset) * height,
					"<",
					arrowButtonWidth, arrowButtonWidth, scale, leftArrowBackgroundColor, leftArrowTextColor, alpha
				);
				
				
				// Progress bar
				var pbx = buttonPosX + arrowButtonWidth * scale
				draw_label_width(
					pbx,
					margin + (i + heightOffset) * height,
					" ", maxwidth, maxwidth, scale, b.textColor, b.backgroundColor, alpha
				);
				
				draw_label_width(
					pbx,
					margin + (i + heightOffset) * height,
					" ", width, maxwidth, scale, b.backgroundColor, b.textColor, alpha
				);
				
				// Right Button
				draw_label_width(
					buttonPosX + ((arrowButtonWidth + maxwidth) * scale),
					margin + (i + heightOffset) * height,
					">",
					arrowButtonWidth, arrowButtonWidth, scale, rightArrowBackgroundColor, rightArrowTextColor, alpha
				);
				
				draw_set_halign(fa_left);
				draw_text_transformed_color(pbx, margin + (i + heightOffset) * height, str, scale, scale, 0, color, color, color, color, 1);
				
				draw_set_halign(fa_center);
				
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
	
	draw_set_font(fnt_menu);
	
	var c0 = 0x000;
	
	draw_set_alpha(0.5 * (menuPosX / menuPosXFinal));
	
	draw_rectangle_color(0, 0, WIDTH, HEIGHT, c_black, c_black, c_black, c_black, false);
	
	gpu_set_blendmode(bm_add);
	
	var offsetx = 200;
	draw_rectangle_color(-offsetx, 0, WIDTH - offsetx, HEIGHT, backgroundColor, c_black, c_black, backgroundColor, false);
	
	gpu_set_blendmode(bm_normal);
	
	draw_set_alpha(1);
	
	
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
	
	draw_set_font(fnt_console);
}




