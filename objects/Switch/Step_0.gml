


if (active && !is_undefined(timer)) {
  timer -= GameSpeed;
	
  if (timer <= 0) {
    active = false;
		timer = defaultTimer;
		
		interactable_find_link(Switch, function(obj) {
		  obj.active = !obj.active;
			obj.animation = true;
		});
  }
}

