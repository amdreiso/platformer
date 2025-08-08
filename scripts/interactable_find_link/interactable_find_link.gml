function interactable_find_link(obj, fn=function(){}){
	with (Interactable) {
    if (ID == other.ID && object_index != obj) {
			fn(self);
    }
  }
}