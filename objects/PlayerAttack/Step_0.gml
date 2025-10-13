
//attacking = (image_index > 6 && image_index < 9);

x = floor(Player.x);
y = floor(Player.y);

image_xscale = Player.image_xscale;

dir.x = Player.hsp * image_xscale;

collisions();

