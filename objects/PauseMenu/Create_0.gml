
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
alpha = 0;

setPage = function(val) {
	PauseMenu.buttonIndex = 0;
	PauseMenu.page = val;
}

enum MENU_BUTTON_TYPE {
	Method,
	Slider,
}

function Button(name, backgroundColor, textColor, fn, goback = false) constructor {
	self.type = MENU_BUTTON_TYPE.Method;
	self.name = name;
	self.fn = fn;
	self.backgroundColor = backgroundColor;
	self.textColor = textColor;
	self.goback = goback;
}

function ButtonSlider(name, backgroundColor, textColor, get, set, variabledefault, slope=0.1) constructor {
	self.type = MENU_BUTTON_TYPE.Slider;
	self.name = name;
	self.backgroundColor = backgroundColor;
	self.textColor = textColor;
	self.get = get;
	self.set = set;
	self.variabledefault = variabledefault;
	self.slope = slope;
}

homeButtons = [];
optionButtons = [];
optionAudioButtons = [];
optionGraphicButtons = [];

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

TRANSLATION.Add("menu_pause_particles")
	.set(LANGUAGE_ID.English, "Max particles on screen")
	.set(LANGUAGE_ID.Brazilian, "Máx. de partículas na tela")
	.finalize();

#endregion

setButtons = function() {
	
	var t = function(val){
		return TRANSLATION.Get("menu_pause_" + val);
	}
	
	var c0 = make_color_rgb(35, 35, 35);
	
	homeButtons = [
		new Button(t("resume"), c0, c_black, function(){
			PauseMenu.active = false;
		}),
		
		new Button(t("options"), c0, c_black, function(){
			setPage(MENU_PAGE.Options);
		}),
		
		new Button(t("quit"), c0, c_blue, function(){
			game_end();
		}),
	];
	
	optionButtons = [
		new Button(t("return"), c0, c_white, function(){
			setPage(MENU_PAGE.Home);
		}),
		
		new Button(TRANSLATION.Get("language_" + string(Language)), c0, c_white, function(){
			if (Language < LANGUAGE_ID.Count - 1) {
				Language ++;
			} else {
				Language = 0;
			}
		}),
		
		new Button(t("graphics"), c0, c_black, function(){
			setPage(MENU_PAGE.OptionsGraphics);
		}),	
	
		new Button(t("audio"), c0, c_black, function(){
			setPage(MENU_PAGE.OptionsAudio);
		}),	
	];

	optionGraphicButtons = [
		new Button(t("return"), c0, c_white, function(){
			setPage(MENU_PAGE.Options);
		}),
	
		new Button(t("scanlines"), c0, c_white, function(){
			Settings.graphics.drawScanlines = !Settings.graphics.drawScanlines;
		}),
	
		new Button(t("ui"), c0, c_white, function(){
			Settings.graphics.drawUI = !Settings.graphics.drawUI;
		}),
		
		new ButtonSlider(t("particles"), c0, Style.sliderBackground, 
								function(){ return Settings.graphics.maxParticlesOnScreen; },
								function(v){ Settings.graphics.maxParticlesOnScreen = clamp(v, 0, 1000); },
								1000.00, 1),
		
	];

	optionAudioButtons = [
		new Button(t("return"), c0, c_white, function(){
			setPage(MENU_PAGE.Options);
		}),
	
		new ButtonSlider(t("volume"), c0, Style.sliderBackground, 
								function(){ return Settings.audio.volume; },
								function(v){ Settings.audio.volume = clamp(v, 0, 1); },
								1.00, 0.005),
	
		new ButtonSlider(t("music"), c0, Style.sliderBackground, 
								function(){ return Settings.audio.music; },
								function(v){ Settings.audio.music = clamp(v, 0, 1); },
								1.00, 0.005),
	
		new ButtonSlider(t("sfx"), c0, Style.sliderBackground, 
								function(){ return Settings.audio.sfx; },
								function(v){ Settings.audio.sfx = clamp(v, 0, 1); },
								1.00, 0.005),
	];

}

setButtons();
buttonIndex = 0;
menuWidth = 550;

drawButtons = function(arr = homeButtons) {
	if (!active) return;
	
	var click				= (Keymap.select);
	var up					= (Keymap.selectUp);
	var down				= (Keymap.selectDown);
	var left				= (Keymap.selectLeft);
	var right				= (Keymap.selectRight);
	var lefthold		= (Keymap.selectLeftHold);
	var righthold		= (Keymap.selectRightHold);
	
	var c0 = c_black;
	var scale = 1;
	
	var buttonPadding = 1.25;

	for (var i = 0; i < array_length(arr); i++) {
		var b = arr[i];
		var str = b.name;
		
		var shift = 0;
		
		if (buttonIndex > 5) {
			shift = buttonIndex - 5;
		}
		
		var ii = i - shift;
		
		var width = string_width(str) * scale;
		var height = string_height(str) * buttonPadding * scale;
		
		str = string_insert(" ", str, 0);
		str = string_insert(str, " ", 0);
		
		var buttonBackground = c_ltgray;
		var buttonForeground = c_white;
		
		var screenMargin = 50;
		
		if (buttonIndex == i) {
			//str = string_insert("> ", str, 0);
			//str = string_insert(str, " <", 0);
			draw_rectangle_color(
				0, screenMargin + ii * height, 
				menuWidth, screenMargin + ii * height + height, 
				
				buttonBackground, buttonBackground, buttonBackground, buttonBackground, false
			);
			buttonForeground = c_black;
		} else {
			buttonBackground = color_darkness(buttonBackground, 50);
		}
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		
		switch (b.type) {
			case MENU_BUTTON_TYPE.Method:
				
				draw_text_color(
					menuWidth / 2, screenMargin + ii * height, b.name, 
					buttonForeground, buttonForeground, buttonForeground, buttonForeground, 1
				);
				
				break;
				
			case MENU_BUTTON_TYPE.Slider:
				
				var value = b.get();
				
				draw_text_color(
					menuWidth / 2, screenMargin + ii * height, b.name + $": {value}", 
					buttonForeground, buttonForeground, buttonForeground, buttonForeground, 1
				);
				
				break;
		}
		
	}
	
	if (Debug.console) return;
	
	if (click && arr[buttonIndex].type == MENU_BUTTON_TYPE.Method) {
		arr[buttonIndex].fn();
		setButtons();
		if (arr[buttonIndex].goback) then buttonIndex = 0;
	}
	
	if (lefthold && arr[buttonIndex].type == MENU_BUTTON_TYPE.Slider) {
		var b = arr[buttonIndex];
		
		var current = b.get();
		b.set( current - b.slope );
		
		setButtons();
	}
	
	if (righthold && arr[buttonIndex].type == MENU_BUTTON_TYPE.Slider) {
		var b = arr[buttonIndex];
		
		var current = b.get();
		b.set( current + b.slope );
		
		setButtons();
	}
	
	var len = array_length(arr);
	if (up && buttonIndex > -1) {
		buttonIndex --;
		//audio_stop_sound(snd_select_menu);
		//audio_play_sound(snd_select_menu, 0, false, 1, 0, random_range(0.87, 1.00));
		if (buttonIndex == -1) then buttonIndex = len - 1;
	}
	
	if (down && buttonIndex < len) {
		buttonIndex ++;
		//audio_stop_sound(snd_select_menu);
		//audio_play_sound(snd_select_menu, 0, false, 1, 0, random_range(0.87, 1.00));
		if (buttonIndex == len) then buttonIndex = 0;
	}
}

drawMenu = function() {
	if (!active) return;
	
	draw_set_font(fnt_menu);
	
	var c0 = c_black;
	
	draw_set_alpha(0.65);
	draw_rectangle_color(0, 0, menuWidth, HEIGHT, c0, c0, c0, c0, false);
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




