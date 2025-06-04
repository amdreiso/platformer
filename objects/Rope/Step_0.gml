	
if (!apply) return;

var radius = 8;

if (distance_to_object(Player) > 300) return;

for (var i = 0; i < array_length(rope); i++) {
  if (!rope[i].pinned)
    rope_update_point(rope[i], Gravity);
	
	var rp = rope[i];
	if (rp.pinned) continue;
	
	for (var j = 0; j < array_length(rp.children); j++) {
		var child = rp.children[j];
		
		child.x = rp.x;
		child.y = rp.y;
		child.image_angle = point_direction(rp.x, rp.y, x, y) - 90;
	}
	
	var obj_list = [Player, Enemy, Collision];

  for (var j = 0; j < array_length(obj_list); j++) {
    var obj = obj_list[j];
		
		with (obj) {
	    var dx = rp.x - x;
	    var dy = rp.y - y;
	    var dist = point_distance(rp.x, rp.y, x, y);

	    if (dist < radius) {
	      var overlap = radius - dist;
	      var nx = dx / dist;
	      var ny = dy / dist;

		    rp.x += nx * overlap;
		    rp.y += ny * overlap;
	    }
	  }
	}
}

for (var j = 0; j < 5; j++) {
  for (var i = 0; i < segments - 1; i++) {
    rope_apply_constraint(rope[i], rope[i + 1], length);
  }
}


