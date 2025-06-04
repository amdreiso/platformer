
if (active && timer != -1) {
  timer -= GameSpeed;
	
  if (timer <= 0) {
    active = false;
		timer = defaultTimer;
		
    with (par_interactive) {
      if (ID == other.ID && object_index != Switch) {
        active = !active;
				animation = true;
      }
    }
  }
}
