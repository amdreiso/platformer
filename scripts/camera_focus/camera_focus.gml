function camera_focus(target, zoom = 1){

if (!instance_exists(Camera)) return;

Camera.target = target;
Camera.zoom = zoom;

}