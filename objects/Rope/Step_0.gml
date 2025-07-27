	
if (!apply) return;

var radius = 8;

var dx = x - Player.x;
var dy = y - Player.y;
if (dx * dx + dy * dy > sqr(Camera.size.width)) return;

var ropeLen = array_length(rope);

var list = ds_list_create();

for (var i = 0; i < ropeLen; i++) {
	var rp = rope[i];
	
	if (!rp.pinned)
    rope_update_point(rp);
	else continue;
	
	for (var j = 0; j < array_length(rp.children); j++) {
		var child = rp.children[j];
		
		child.x = rp.x;
		child.y = rp.y;
		child.image_angle = point_direction(rp.x, rp.y, x, y) - 90;
	}
	
	var collisions = [Player, Collision];
	//collision_circle_list(rp.x, rp.y, radius, self, false, true, collisions, false);
	
  for (var j = 0; j < array_length(collisions); j++) {
    var obj = collisions[j];
		
		if (!instance_exists(obj)) break;
		
		ds_list_clear(list);
		if (collision_circle_list(rp.x, rp.y, radius, obj, false, true, list, false)) {
			for (var k = 0; k < ds_list_size(list); k++) {
				var inst = list[| k];

				var dx = rp.x - inst.x;
				var dy = rp.y - inst.y;
				var dist = sqrt(dx * dx + dy * dy);
				if (dist == 0) continue;

				if (dist < radius) {
					var overlap = radius - dist;
					var nx = dx / dist;
					var ny = dy / dist;

					rp.x += nx * overlap;
					rp.y += ny * overlap;
				}
			}
		}
		
		//with (obj) {
	  //  var dx = rp.x - x;
	  //  var dy = rp.y - y;
	  //  var dist = point_distance(rp.x, rp.y, x, y);

	  //  if (dist < radius) {
	  //    var overlap = radius - dist;
	  //    var nx = dx / dist;
	  //    var ny = dy / dist;

		//    rp.x += nx * overlap;
		//    rp.y += ny * overlap;
	  //  }
	  //}
	}
}

for (var j = 0; j < 5; j++) {
  for (var i = 0; i < segments - 1; i++) {
    rope_apply_constraint(rope[i], rope[i + 1], length);
  }
}


