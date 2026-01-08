
function translation_init(){
	
	globalvar TranslationData; TranslationData = ds_map_create();
	globalvar TRANSLATION;
	
	TRANSLATION = {
		Add: function(key) {
			token = ds_map_create();
			_key = key;
			
			methods = {};
			methods.set = function(languageID, str) {
				token[? languageID] = str;
				
				var lang = "ENGLISH";
				
				switch (languageID) {
					case LANGUAGE_ID.English: lang = "ENGLISH"; break;
					case LANGUAGE_ID.Brazilian: lang = "BRAZILIAN"; break;
				}
				
				print($"Translation: KEY: {_key} | {lang} : {str}");
				return methods;
			}
			
			methods.finalize = function() {
				TranslationData[? _key] = token;
			}
			
			return methods;
		},
		
		Get: function(key, lang=undefined) {
			// tries to get translation, if undefined, returns english
			if (lang == undefined) return TranslationData[? key][? Language] ?? TranslationData[? key][? LANGUAGE_ID.English];
			try {
				return TranslationData[? key][? LANGUAGE_ID.English];
			} catch(e) {
				return "Missing Translation";
			}
		},
	};
	
	#region Languages
	
	TRANSLATION.Add("language_" + string(LANGUAGE_ID.English))
		.set(LANGUAGE_ID.English, "English")
		.set(LANGUAGE_ID.Brazilian, "Inglês")
		.finalize();
	
	TRANSLATION.Add("language_" + string(LANGUAGE_ID.Brazilian))
		.set(LANGUAGE_ID.English, "Brazilian")
		.set(LANGUAGE_ID.Brazilian, "Brasileiro")
		.finalize();
	
	#endregion
	
	#region GUI
	
	TRANSLATION.Add("gui_quest_find")
		.set(LANGUAGE_ID.English, "find: ")
		.set(LANGUAGE_ID.Brazilian, "encontre: ")
		.finalize();
	
	TRANSLATION.Add("gui_death_screen_message")
		.set(LANGUAGE_ID.English, "you died dumbass")
		.set(LANGUAGE_ID.Brazilian, "você morreu burrao")
		.finalize();
	
	
	// TODO: Poem
	TRANSLATION.Add("gui_death_screen_poem")
		.set(LANGUAGE_ID.English, "cringe")
		.set(LANGUAGE_ID.Brazilian, "")
		.finalize();
		
		
	// Inventory
	TRANSLATION.Add("gui_inventory_name")
		.set(LANGUAGE_ID.English, "name")
		.set(LANGUAGE_ID.Brazilian, "nome")
		.finalize();
	
	TRANSLATION.Add("gui_inventory_type")
		.set(LANGUAGE_ID.English, "type")
		.set(LANGUAGE_ID.Brazilian, "tipo")
		.finalize();
	
	TRANSLATION.Add("gui_inventory_slot_sword")
		.set(LANGUAGE_ID.English, "sword")
		.set(LANGUAGE_ID.Brazilian, "espada")
		.finalize();
	
	TRANSLATION.Add("gui_inventory_slot_armor")
		.set(LANGUAGE_ID.English, "armor")
		.set(LANGUAGE_ID.Brazilian, "armadura")
		.finalize();
	
	TRANSLATION.Add("gui_inventory_slot_module")
		.set(LANGUAGE_ID.English, "mod")
		.set(LANGUAGE_ID.Brazilian, "mód")
		.finalize();
	
	
	#endregion
	
	#region Cutscenes
	
	// Beggining Cutscene
	TRANSLATION.Add("cutscene_beggining_0")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]I know you are not cognitive...[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]eu sei que você não é cognitivo...[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_beggining_1")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]but I know that...[speed=2] [/speed][speed=10]deep inside...[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]mas eu sei que...[speed=2] [/speed][speed=10]lá no fundo...[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_beggining_2")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=8][shake=1.1]you still have a [color=#eeee55]soul[/color]...[/shake][/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=8][shake=1.1]você ainda tem uma [color=#eeee55]alma[/color]...[/shake][/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_beggining_3")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]a soul that can understand.[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]uma alma que pode entender.[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_beggining_4")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=15]I'm no engineer[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=15]eu não sou engenheiro[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_beggining_5")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=15]I'm no electrician[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=15]eu não sou eletricista[/speed][/italic][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_beggining_6")
		.set(LANGUAGE_ID.English, "[scale=2.5][italic][speed=10]I just want a better future for ourselves...[/speed][/italic][/scale]")
		.set(LANGUAGE_ID.Brazilian, "[scale=2.5][italic][speed=10]eu só quero um futuro melhor pra gente...[/speed][/italic][/scale]")
		.finalize();
	
	
	#region BOSS Waste Reaper
	
	TRANSLATION.Add("cutscene_junkeeper_0")
		.set(LANGUAGE_ID.English, $"[scale=1.25][shake=1]YOU SHOULDN'T HAVE COME HERE![/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.25][shake=1]VOCÊ NÃO DEVIA TER VINDO AQUI![/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_1")
		.set(LANGUAGE_ID.English, $"[scale=1.25][shake=1]THIS JUNK IS ALL MINE!!![/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.25][shake=1]ESSE LIXO É TODO MEU!!![/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_2")
		.set(LANGUAGE_ID.English, $"[scale=0.55][shake=0.1][italic]...actually... thinking about it...[/italic][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=0.55][shake=0.1][italic]...na verdade... pensando bem...[/italic][/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_3")
		.set(LANGUAGE_ID.English, $"[scale=0.55][shake=0.1][italic]...your circuits would be a fine addition to my garbage collection...[/italic][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=0.55][shake=0.1][italic]...seus circuitos seriam uma boa adição para a minha coleção de lixo...[/italic][/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_4")
		.set(LANGUAGE_ID.English, $"[scale=0.55][shake=0.1][italic]...but first... I'll have to destroy you...[/italic][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=0.55][shake=0.1][italic]...mas antes... eu terei que te destruir...[/italic][/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_5")
		.set(LANGUAGE_ID.English, $"[scale=1.55][shake=0.5][color=red][speed=20]BOOT YOURSELF![/speed][/color][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.55][shake=0.5][color=red][speed=20]SE LIGUE![/speed][/color][/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_nohands_0")
		.set(LANGUAGE_ID.English, $"[scale=1.45][shake=0.5][speed=20]MY HANDS!!![/speed][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1.45][shake=0.5][speed=20]MINHAS MÃOS!!![/speed][/shake][/scale]")
		.finalize();
		
	TRANSLATION.Add("cutscene_junkeeper_nohands_1")
		.set(LANGUAGE_ID.English, $"[scale=1][shake=0.5][speed=20]YOU WILL PAY FOR THIS YOU USELESS [color=red]CLANKER[/color]!!![/speed][/shake][/scale]")
		.set(LANGUAGE_ID.Brazilian, $"[scale=1][shake=0.5][speed=20]VOCÊ VAI PAGAR POR ISSO SUA [color=red]SUCATA[/color] INÚTIL!!![/speed][/shake][/scale]")
		.finalize();
	
	#endregion
	
	
	
	
	#endregion
	
	#region Levels
	
	#region Caves
	
	TRANSLATION.Add("cave_entrance_robot_examine_0")
		.set(LANGUAGE_ID.English, "it's broken.")
		.set(LANGUAGE_ID.Brazilian, "tá quebrado.")
		.finalize();
	
	
	TRANSLATION.Add("cave_entrance_robot_fixed_0")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.Add("cave_entrance_robot_fixed_1")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	TRANSLATION.Add("cave_entrance_robot_fixed_2")
		.set(LANGUAGE_ID.English, "text here...")
		.set(LANGUAGE_ID.Brazilian, "text here...")
		.finalize();
	
	
	TRANSLATION.Add("cave_entrance_flowerstatue_0")
		.set(LANGUAGE_ID.English, "[italic]the statue holds a [color=#ffff0f]flower[/color][/italic]")
		.set(LANGUAGE_ID.Brazilian, "[italic]a estátua segura uma [color=#ffff0f]flor[/color][/italic]")
		.finalize();
	
	#endregion
	
	#endregion
	
	#region Items
	
	var prefixItem = "item_";
	
	TRANSLATION.Add(prefixItem + string(ITEM_ID.ScrapElectronics))
		.set(LANGUAGE_ID.English, "Scrap electronics")
		.set(LANGUAGE_ID.Brazilian, "Resto de eletrônicos")
		.finalize();
	
	TRANSLATION.Add(prefixItem + string(ITEM_ID.Jetpack))
		.set(LANGUAGE_ID.English, "Jetpack")
		.set(LANGUAGE_ID.Brazilian, "Mochila a jato")
		.finalize();
	
	TRANSLATION.Add(prefixItem + string(ITEM_ID.BaseballBat))
		.set(LANGUAGE_ID.English, "Baseball bat")
		.set(LANGUAGE_ID.Brazilian, "Taco de beisebol")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.FlameSpell))
		.set(LANGUAGE_ID.English, "Flame spell")
		.set(LANGUAGE_ID.Brazilian, "Feitiço de chamas")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.FreezeSpell))
		.set(LANGUAGE_ID.English, "Ice spell")
		.set(LANGUAGE_ID.Brazilian, "Feitiço de gelo")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.KnockbackSpell))
		.set(LANGUAGE_ID.English, "Knockback spell")
		.set(LANGUAGE_ID.Brazilian, "Feitiço de impulso")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.StrengthSpell))
		.set(LANGUAGE_ID.English, "Strength spell")
		.set(LANGUAGE_ID.Brazilian, "Feitiço de força")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.PoisonSpell))
		.set(LANGUAGE_ID.English, "Poison spell")
		.set(LANGUAGE_ID.Brazilian, "Feitiço de veneno")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.DevStick))
		.set(LANGUAGE_ID.English, "Dev")
		.set(LANGUAGE_ID.Brazilian, "Dev")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.Armor))
		.set(LANGUAGE_ID.English, "Armor")
		.set(LANGUAGE_ID.Brazilian, "Armadura")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.HighJumpModule))
		.set(LANGUAGE_ID.English, "High jump module")
		.set(LANGUAGE_ID.Brazilian, "Módulo de pulo alto")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.PortalCasterModule))
		.set(LANGUAGE_ID.English, "Portal caster module")
		.set(LANGUAGE_ID.Brazilian, "Módulo atirador de portal")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.Dynamite))
		.set(LANGUAGE_ID.English, "Dynamite")
		.set(LANGUAGE_ID.Brazilian, "Dinamite")
		.finalize();
		
	TRANSLATION.Add(prefixItem + string(ITEM_ID.Gold))
		.set(LANGUAGE_ID.English, "Gold")
		.set(LANGUAGE_ID.Brazilian, "Ouro")
		.finalize();
		
		
	#endregion
	
	#region Item Types
	
	var pItemType = "item_type_";
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Blank))
		.set(LANGUAGE_ID.English, "Common")
		.set(LANGUAGE_ID.Brazilian, "Comum")
		.finalize();
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Armor))
		.set(LANGUAGE_ID.English, "Armor")
		.set(LANGUAGE_ID.Brazilian, "Armadura")
		.finalize();
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Sword))
		.set(LANGUAGE_ID.English, "Sword")
		.set(LANGUAGE_ID.Brazilian, "Espada")
		.finalize();
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Module))
		.set(LANGUAGE_ID.English, "Module")
		.set(LANGUAGE_ID.Brazilian, "Módulo")
		.finalize();
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Spell))
		.set(LANGUAGE_ID.English, "Spell")
		.set(LANGUAGE_ID.Brazilian, "Feitiço")
		.finalize();
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Key))
		.set(LANGUAGE_ID.English, "Key")
		.set(LANGUAGE_ID.Brazilian, "Chave")
		.finalize();
	
	TRANSLATION.Add(pItemType + string(ITEM_TYPE.Ring))
		.set(LANGUAGE_ID.English, "Ring")
		.set(LANGUAGE_ID.Brazilian, "Anél")
		.finalize();
	
	#endregion
	
	#region Spells
	
	#endregion
	
	#region Effects
	
	#endregion
	
}
