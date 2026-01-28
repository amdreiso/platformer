
if (active && !is_undefined(tick)) {
  tick -= GameSpeed;
	
  if (tick <= 0) {
    active = false;
		tick = time;
  }
}

