
segments = 10;
createSegments();

var light = instance_create_depth(x, y, depth, Light);
light.intensity = 14;
light.sprite = sChainLamp;

append(segments-1, light);
