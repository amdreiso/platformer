
//if (place_meeting(x, y, PlayerAttack)) {
//	if (!PlayerAttack.used) {
//		hit();
//		PlayerAttack.used = true;
//	}
//}

player_attack_check(function(a){
	hit();
});


if (sprite != -1 && surface == -1) {
	var w, h;
	w = sprite_get_width(sprite);
	h = sprite_get_height(sprite);
	
	surface = surface_create(w, h);
}
