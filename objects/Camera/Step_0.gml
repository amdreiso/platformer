
cam = view_camera[CameraViewport];

if (target == noone || !active) return;


if (shakeValue > 0) shakeValue -= GameSpeed / 2; else shakeValue = 0;

var shake = power(shakeValue, shakePower) * Settings.graphics.cameraShakeIntensity;

xTo = target.x + offset.x;
yTo = target.y + offset.y;

x = lerp(x, xTo, followSpeed);
y = lerp(y, yTo, followSpeed);


camera_set_view_angle(cam, angle);
camera_set_view_size(cam, defaultSize.width * zoomLerp, defaultSize.height * zoomLerp);

//camera_set_view_pos(cam, x - (size.width * zoomLerp) / 2, y - (size.height * zoomLerp) / 2);

var view_w = defaultSize.width * zoomLerp;
var view_h = defaultSize.height * zoomLerp;

pos.x = clamp(x - view_w / 2, 0, room_width - view_w);
pos.y = clamp(y - view_h / 2, 0, room_height - view_h);

pos.x += random_range(-shake, shake);
pos.y += random_range(-shake, shake);

camera_set_view_pos(cam, pos.x, pos.y);

zoomLerp = lerp(zoomLerp, zoom, zoomSpd);

var zoomValue = 0.5;
//zoom += (mouse_wheel_down() && zoom < 2) ? zoomValue : 0;
//zoom -= (mouse_wheel_up() && zoom > 0.5) ? zoomValue : 0;

