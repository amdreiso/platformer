

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

Button = function(name, backgroundColor, textColor, fn, goback = false) {
	return {
		type: MENU_BUTTON_TYPE.Method,
		name: name,
		fn: fn,
		backgroundColor: backgroundColor,
		textColor: textColor,
		goback: goback,
	}
}

ButtonSlider = function(name, backgroundColor, textColor, get, set, variabledefault, slope=0.1) {
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

homeButtons = [];
optionButtons = [];
optionAudioButtons = [];
optionGraphicButtons = [];
devButtons = [];

#region Menu Translations

TRANSLATION.Add("menu_pause_resume")
	.set(LANGUAGE_ID.English, "Resume")
	.set(LANGUAGE_ID.Brazilian, "Resumir")
	.finalize();

TRANSLATION.Add("menu_pause_return")
	.set(LANGUAGE_ID.English, "Return")
	.set(LANGUAGE_ID.Brazilian, "Voltar")
	.finalize();

TRANSLATION.Add("menu_pause_options")
	.set(LANGUAGE_ID.English, "Options")
	.set(LANGUAGE_ID.Brazilian, "Opções")
	.finalize();

TRANSLATION.Add("menu_pause_about")
	.set(LANGUAGE_ID.English, "About")
	.set(LANGUAGE_ID.Brazilian, "Sobre")
	.finalize();

TRANSLATION.Add("menu_pause_quit")
	.set(LANGUAGE_ID.English, "Quit")
	.set(LANGUAGE_ID.Brazilian, "Sair")
	.finalize();

TRANSLATION.Add("menu_pause_graphics")
	.set(LANGUAGE_ID.English, "Graphics")
	.set(LANGUAGE_ID.Brazilian, "Gráfico")
	.finalize();

TRANSLATION.Add("menu_pause_audio")
	.set(LANGUAGE_ID.English, "Audio")
	.set(LANGUAGE_ID.Brazilian, "Áudio")
	.finalize();

TRANSLATION.Add("menu_pause_scanlines")
	.set(LANGUAGE_ID.English, "Toggle scanlines")
	.set(LANGUAGE_ID.Brazilian, "Ativar linhas de varredura")
	.finalize();

TRANSLATION.Add("menu_pause_ui")
	.set(LANGUAGE_ID.English, "Toggle UI")
	.set(LANGUAGE_ID.Brazilian, "Ativar interface de usuário")
	.finalize();

TRANSLATION.Add("menu_pause_volume")
	.set(LANGUAGE_ID.English, "Volume")
	.set(LANGUAGE_ID.Brazilian, "Volume")
	.finalize();

TRANSLATION.Add("menu_pause_music")
	.set(LANGUAGE_ID.English, "Music")
	.set(LANGUAGE_ID.Brazilian, "Música")
	.finalize();

TRANSLATION.Add("menu_pause_sfx")
	.set(LANGUAGE_ID.English, "SFX")
	.set(LANGUAGE_ID.Brazilian, "Efeitos sonoros")
	.finalize();

#endregion

setButtons = function() {
	
	var t = function(val){
		return TRANSLATION.Get("menu_pause_" + val);
	}
	
	homeButtons = [
		Button(t("resume"), c_white, c_black, function(){
			PauseMenu.active = false;
		}),
		
		Button(t("options"), c_green, c_black, function(){
			setPage(MENU_PAGE.Options);
		}),
		
		Button(t("about"), c_red, c_black, function(){
			setPage(MENU_PAGE.Dev);
		}),
		
		Button(t("quit"), c_orange, c_blue, function(){
			game_end();
		}),
	];
	
	optionButtons = [
		Button(t("return"), c_blue, c_white, function(){
			setPage(MENU_PAGE.Home);
		}),
		
		Button(TRANSLATION.Get("language_" + string(Language)), c_white, c_white, function(){
			if (Language < LANGUAGE_ID.Count - 1) {
				Language ++;
			} else {
				Language = 0;
			}
		}),
		
		Button(t("graphics"), c_fuchsia, c_black, function(){
			setPage(MENU_PAGE.OptionsGraphics);
		}),	
	
		Button(t("audio"), c_aqua, c_black, function(){
			setPage(MENU_PAGE.OptionsAudio);
		}),	
	];

	optionGraphicButtons = [
		Button(t("return"), c_blue, c_white, function(){
			setPage(MENU_PAGE.Options);
		}),
	
		Button(t("scanlines"), make_color_rgb(35, 35, 35), c_white, function(){
			Settings.graphics.drawScanlines = !Settings.graphics.drawScanlines;
		}),
	
		Button(t("ui"), make_color_rgb(35, 35, 35), c_white, function(){
			Settings.graphics.drawUI = !Settings.graphics.drawUI;
		}),
	];

	optionAudioButtons = [
		Button(t("return"), c_blue, c_white, function(){
			setPage(MENU_PAGE.Options);
		}),
	
		ButtonSlider(t("volume"), $FFCBA646, Style.sliderBackground, 
								function(){ return Settings.audio.volume; },
								function(v){ Settings.audio.volume = clamp(v, 0, 1); settings_save(); },
								1.00, 0.005),
	
		ButtonSlider(t("music"), make_color_rgb(200, 200, 80), Style.sliderBackground, 
								function(){ return Settings.audio.music; },
								function(v){ Settings.audio.music = clamp(v, 0, 1); settings_save(); },
								1.00, 0.005),
	
		ButtonSlider(t("sfx"), make_color_rgb(170, 130, 220), Style.sliderBackground, 
								function(){ return Settings.audio.sfx; },
								function(v){ Settings.audio.sfx = clamp(v, 0, 1); settings_save(); },
								1.00, 0.005),
	];

	devButtons = [
		Button(t("return"), c_blue, c_white, function(){
			setPage(MENU_PAGE.Home);
		}),
	
		Button("discord", make_color_rgb(100, 100, 255), c_white, function(){
			url_open("https://discord.gg/hkfcYf8pDS");
		}),
	
	];

}

setButtons();

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
		
		str = string_insert(" ", str, 0);
		str = string_insert(str, " ", 0);
		
		if (buttonIndex == i) {
			//str = string_insert("> ", str, 0);
			//str = string_insert(str, " <", 0);
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
				var widthMultiplier						= 2;
				var current										= b.get();
				var step											= (current / b.variabledefault);
				var width											= maxwidth * step * widthMultiplier;
				var arrowButtonWidth					= 50;
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
				
				// Left Button
				draw_label_width(
					buttonPosX,
					margin + (i + heightOffset) * height,
					"<",
					arrowButtonWidth, arrowButtonWidth, scale, leftArrowBackgroundColor, leftArrowTextColor, alpha
				);
				
				// Progress bar
				var padding = 5;
				var pbx = buttonPosX + arrowButtonWidth * scale
				
				draw_label_width(
					pbx,
					margin + (i + heightOffset) * height,
					" ", width - padding, maxwidth - padding, scale, b.backgroundColor, b.textColor, alpha
				);
				
				// Right Button
				draw_label_width(
					buttonPosX + ((arrowButtonWidth + maxwidth * widthMultiplier) * scale),
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
		setButtons();
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




