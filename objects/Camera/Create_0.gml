
isSolid = false;
cam = view_camera[0];

defaultSize = dim(
	camera_get_view_width(cam),
	camera_get_view_height(cam)
);

size = dim(
	camera_get_view_width(cam),
	camera_get_view_height(cam)
);

shakeValue = 0;
shakePower = 1;

target = noone;
offset = vec2();
followSpeed = 0.25;

zoom = 1;
zoomLerp = zoom;
zoomSpd = 0.2;

angle = 0;

pos = vec2();


