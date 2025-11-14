
function translation_init(){
	
	globalvar TranslationData; TranslationData = ds_map_create();
	globalvar TRANSLATION;
	
	TRANSLATION = {
		add: function(key) {
			token = ds_map_create();
			_key = key;
			
			methods = {};
			methods.set = function(languageID, str) {
				token[? languageID] = str;
				return methods;
			}
			
			methods.finalize = function() {
				TranslationData[? _key] = token;
			}
			
			return methods;
		},
		
		get: function(key, lang=undefined) {
			// tries to get translation, if undefined, returns english
			if (lang == undefined) return TranslationData[? key][? Language] ?? TranslationData[? key][? LANGUAGE_ID.English];
			return TranslationData[? key][? LANGUAGE_ID.English];
		},
	};
	
	#region GUI
	
	TRANSLATION.add("gui_quest_find")
		.set(LANGUAGE_ID.English, "find: ")
		.set(LANGUAGE_ID.Brazilian, "encontre: ")
		.finalize();
	
	TRANSLATION.add("gui_death_screen_message")
		.set(LANGUAGE_ID.English, "you died dumbass")
		.set(LANGUAGE_ID.Brazilian, "você morreu burrao")
		.finalize();
	
	// TODO: Poem
	TRANSLATION.add("gui_death_screen_poem")
		.set(LANGUAGE_ID.English, "cringe")
		.set(LANGUAGE_ID.Brazilian, "")
		.finalize();
	
	
	#endregion
	
	#region Cutscenes
	
	// Beggining Cutscene
	TRANSLATION.add("cutscene_beggining_0")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]I know you are not cognitive...[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]eu sei que você não é cognitivo...[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_beggining_1")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]but I know that...[speed=2] [/speed][speed=10]deep inside...[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]mas eu sei que...[speed=2] [/speed][speed=10]lá no fundo...[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_beggining_2")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=8][shake=1.1]you still have a [color=#eeee55]soul[/color]...[/shake][/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=8][shake=1.1]você ainda tem uma [color=#eeee55]alma[/color]...[/shake][/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_beggining_3")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]a soul that can understand.[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]uma alma que pode entender.[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_beggining_4")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=15]I'm no engineer[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=15]eu não sou engenheiro[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_beggining_5")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=15]I'm no electrician[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=15]eu não sou eletricista[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_beggining_6")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]I just want a better future for ourselves...[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]eu só quero um futuro melhor pra gente...[/speed][/italic][/scale]")
		.finalize();
	
	
	
	// Junkeeper Cutscene
	TRANSLATION.add("cutscene_junkeeper_0")
		.set(LANGUAGE_ID.English, $"[scale=1.25][shake=1]YOU SHOULDN'T HAVE COME HERE![/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.25][shake=1]VOCÊ NÃO DEVIA TER VINDO AQUI![/shake][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_junkeeper_1")
		.set(LANGUAGE_ID.English, $"[scale=1.25][shake=1]THIS JUNK IS ALL MINE!!![/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.25][shake=1]ESSE LIXO É TODO MEU!!![/shake][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_junkeeper_2")
		.set(LANGUAGE_ID.English, $"[scale=0.55][shake=0.1][italic]...actually... thinking about it...[/italic][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=0.55][shake=0.1][italic]...na verdade... pensando bem...[/italic][/shake][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_junkeeper_3")
		.set(LANGUAGE_ID.English, $"[scale=0.55][shake=0.1][italic]...your circuits would be a fine addition to my garbage collection...[/italic][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=0.55][shake=0.1][italic]...seus circuitos seriam uma boa adição para a minha coleção de lixo...[/italic][/shake][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_junkeeper_4")
		.set(LANGUAGE_ID.English, $"[scale=0.55][shake=0.1][italic]...but first... I'll have to destroy you...[/italic][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=0.55][shake=0.1][italic]...mas antes... eu terei que te destruir...[/italic][/shake][/scale]")
		.finalize();
		
	TRANSLATION.add("cutscene_junkeeper_5")
		.set(LANGUAGE_ID.English, $"[scale=1.55][shake=0.5][color=red][speed=20]BOOT YOURSELF![/speed][/color][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.55][shake=0.5][color=red][speed=20]SE LIGUE![/speed][/color][/shake][/scale]")
		.finalize();
	
	
	#endregion
	
	#region Levels
	
	#region Caves
	
	TRANSLATION.add("cave_entrance_robot_examine_0")
		.set(LANGUAGE_ID.English, "it's broken.")
		.set(LANGUAGE_ID.Brazilian, "tá quebrado.")
		.finalize();
	
	
	TRANSLATION.add("cave_entrance_robot_fixed_0")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.add("cave_entrance_robot_fixed_1")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.add("cave_entrance_robot_fixed_2")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	
	TRANSLATION.add("cave_entrance_flowerstatue_0")
		.set(LANGUAGE_ID.English, "[italic]the statue holds a [color=#ffff0f]flower[/color][/italic]")
		.set(LANGUAGE_ID.Brazilian, "[italic]a estátua segura uma [color=#ffff0f]flor[/color][/italic]")
		.finalize();
	
	#endregion
	
	#endregion
	
	#region Items
	
	
	TRANSLATION.add(ITEM_ID.ScrapElectronics)
		.set(LANGUAGE_ID.English, "scrap electronics")
		.set(LANGUAGE_ID.Brazilian, "resto de eletrônicos")
		.finalize();
	
	TRANSLATION.add(ITEM_ID.Jetpack)
		.set(LANGUAGE_ID.English, "jetpack")
		.set(LANGUAGE_ID.Brazilian, "mochila a jato")
		.finalize();
	
	TRANSLATION.add(ITEM_ID.BaseballBat)
		.set(LANGUAGE_ID.English, "baseball bat")
		.set(LANGUAGE_ID.Brazilian, "taco de beisebol")
		.finalize();
	
	TRANSLATION.add(ITEM_ID.DevStick)
		.set(LANGUAGE_ID.English, "dev stick")
		.set(LANGUAGE_ID.Brazilian, "dev stick")
		.finalize();
		
	TRANSLATION.add(ITEM_ID.FlameSpell)
		.set(LANGUAGE_ID.English, "flame spell")
		.set(LANGUAGE_ID.Brazilian, "encantamento de chamas")
		.finalize();
		
	TRANSLATION.add(ITEM_ID.FreezeSpell)
		.set(LANGUAGE_ID.English, "ice spell")
		.set(LANGUAGE_ID.Brazilian, "encantamento de gelo")
		.finalize();
		
	TRANSLATION.add(ITEM_ID.KnockbackSpell)
		.set(LANGUAGE_ID.English, "knockback spell")
		.set(LANGUAGE_ID.Brazilian, "encantamento de impulso")
		.finalize();
		
	TRANSLATION.add(ITEM_ID.StrengthSpell)
		.set(LANGUAGE_ID.English, "strength spell")
		.set(LANGUAGE_ID.Brazilian, "encantamento de força")
		.finalize();
		
		
		
	#endregion
	
	#region Spells
	
	#endregion
	
	#region Effects
	
	#endregion
	
}
