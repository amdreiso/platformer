
if (target == noone) return;


if (shakeValue > 0) shakeValue -= GameSpeed / 2; else shakeValue = 0;

var shake = power(shakeValue, shakePower) * Settings.graphics.cameraShakeIntensity;

var xx = target.x + offset.x;
var yy = target.y + offset.y;


x = lerp(x, xx, followSpeed) + random_range(-shake, shake);
y = lerp(y, yy, followSpeed) + random_range(-shake, shake);


camera_set_view_angle(cam, angle);
camera_set_view_size(cam, defaultSize.width * zoomLerp, defaultSize.height * zoomLerp);

//camera_set_view_pos(cam, x - (size.width * zoomLerp) / 2, y - (size.height * zoomLerp) / 2);

var view_w = defaultSize.width * zoomLerp;
var view_h = defaultSize.height * zoomLerp;

var camx = clamp(x - view_w / 2, 0, room_width - view_w);
var camy = clamp(y - view_h / 2, 0, room_height - view_h);

camera_set_view_pos(cam, camx, camy);

zoomLerp = lerp(zoomLerp, zoom, zoomSpd);

var zoomValue = 0.5;
//zoom += (mouse_wheel_down() && zoom < 2) ? zoomValue : 0;
//zoom -= (mouse_wheel_up() && zoom > 0.5) ? zoomValue : 0;

