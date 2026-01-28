function interactable_find_link(obj, fn=function(){}){
	with (Interactable) {
    if (signalID == other.signalID && object_index != obj) {
			fn(self);
    }
  }
}