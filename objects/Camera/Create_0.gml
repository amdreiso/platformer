
active = true;

isSolid = false;
cam = view_camera[0];

defaultSize = new Dim(
	camera_get_view_width(cam),
	camera_get_view_height(cam)
);

size = new Dim(
	camera_get_view_width(cam),
	camera_get_view_height(cam)
);

shakeValue = 0;
shakePower = 1;

target = noone;
offset = new Vec2();
followSpeed = 0.25;

zoom = CAMERA_ZOOM_DEFAULT;
zoomLerp = zoom;
zoomSpd = 0.2;

angle = 0;

pos = new Vec2();
