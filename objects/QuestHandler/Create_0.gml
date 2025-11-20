
Quest = function(title, objective=function(){ return true }) {
	quest = {};
	
	quest.title = title;
	quest.objective = objective;
	
	return quest;
}

quests = [
	//Quest($"find scrap electronics", function() {
	//	if (!instance_exists(Player)) return;
	//	return (Player.inventory.hasItem(ITEM_ID.ScrapElectronics));
	//}),
];

add = function(title, objective=function(){ return true }) {
	array_insert(quests, 0, Quest(title, objective));
}

run = function() {
	for (var i = 0; i < array_length(quests); i++) {
		var q = quests[i];
		if (q.objective()) {
			print($"Completed quest '{q.title}'");
			array_delete(quests, i, 1);
		}
	}
}

draw = function() {
	for (var i = 0; i < array_length(quests); i++) {
		var q = quests[i];
		
		var margin = 10;
		var padding = 10;
		
		var height = 50;
		
		draw_set_halign(fa_right);
		draw_text(WIDTH - margin - padding, (i * height) + margin + padding, q.title);
		
		draw_set_halign(fa_left);
	}
}


