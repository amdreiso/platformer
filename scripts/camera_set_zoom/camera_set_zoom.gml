function camera_set_zoom(zoom, brute=false){
	if (!instance_exists(Camera)) return;
	if (brute) Camera.zoomLerp = zoom;
	Camera.zoom = zoom;
}