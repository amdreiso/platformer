function draw_raycast(light_x, light_y, raycastCount = Settings.graphics.raycastCount, max_distance = 50, width = 1){
	var rays = raycastCount;

	for (var i = 0; i < rays; i++) {
	  var angle = i * (360 / rays);
    
	  var target_x = light_x + lengthdir_x(max_distance, angle);
	  var target_y = light_y + lengthdir_y(max_distance, angle);
    
	  var hit_instance = collision_line(light_x, light_y, target_x, target_y, Collision, false, true);
	  var hit_slope = collision_line(light_x, light_y, target_x, target_y, Collision_Slope, true, true);
    
	  if (hit_instance != undefined || hit_slope != undefined) {
	    var hit_x = target_x;
	    var hit_y = target_y;
        
	    var dist = point_distance(light_x, light_y, target_x, target_y);
	    var step = 1;
	    for (var j = 0; j < dist; j += step) {
	      var px = light_x + lengthdir_x(j, angle);
	      var py = light_y + lengthdir_y(j, angle);
				
	      if (collision_point(px, py, Collision, false, true) || collision_point(px, py, Collision_Slope, true, true)) {
	        hit_x = floor(px);
	        hit_y = floor(py);
	        break;
	      }
	    }
	  }
	  draw_line_width(light_x, light_y, hit_x, hit_y, width);
	}
}