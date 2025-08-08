
x += hsp;
y += vsp;

body.x = x + bodyOffset.x;
body.y = y + bodyOffset.y;

head.x = x + headOffset.x;
head.y = y + headOffset.y;

hsp = (sin(current_time * 0.0005) * 0.25) - hsp / 2;
vsp = cos(current_time * 0.0011) * 0.1;


// head
head.face = face;
