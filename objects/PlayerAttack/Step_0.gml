
attacking = (image_index > 6 && image_index < 9);

x = Player.x;
y = Player.y;

image_xscale = Player.image_xscale;
image_angle = Player.angle;

dir.x = Player.hsp * image_xscale;

collisions();
