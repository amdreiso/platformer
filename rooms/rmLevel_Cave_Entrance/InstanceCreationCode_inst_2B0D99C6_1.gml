
segments = 16;
createSegments();

var light = instance_create_depth(x, y, depth, Light);
light.intensity = 64;
light.sprite = sChainLamp;
light.lightWidth = 3;
ropeAppend(segments-1, light);
