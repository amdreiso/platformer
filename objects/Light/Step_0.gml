
if (is_array(intensity)) {
	var time = floor(current_time);
	if (time % 20 == true) {
		intensityIndex = irandom(array_length(intensity)-1);
	}
	
	intensity[intensityIndex] = max(0, intensity[intensityIndex] - intensityDrop);
	if (intensity[intensityIndex] == 0) instance_destroy();

} else {
	intensity = max(0, intensity - intensityDrop);
	if (intensity == 0) instance_destroy();
	
}
