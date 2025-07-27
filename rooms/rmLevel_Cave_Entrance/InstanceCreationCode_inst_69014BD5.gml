
segments = 2;
createSegments();

var light = instance_create_layer(x, y, "Lighting", Light);
light.intensity = 16;
light.sprite = sChainLamp;
append(segments - 1, light);
