
//collisionTilemap = layer_tilemap_get_id("Collision_Map");

busy = (Paused 
				|| isDead
				|| instance_exists(Textbox) 
				|| Paused
				|| Debug.console
				|| map.open
				|| resetPosition
);

movement();

applyCollisions();

attack();
handleHealth();
handleBackflip();


// Check for tiles
var xchunk = x div ROOM_TILE_WIDTH;
var ychunk = y div ROOM_TILE_HEIGHT;

if (xchunk != lastChunk.x || ychunk != lastChunk.y || room != lastChunk.roomID) {
	lastChunk.x = xchunk;
	lastChunk.y = ychunk;
	lastChunk.roomID = room;
	
	print($"new chunk at x: {xchunk} y: {ychunk}");
	map.discover(room, xchunk, ychunk);
}


// Lighting
viewDistance = viewDistanceDefault * LevelData[? room].components.playerVision;


// Upgrades
upgrade.update();


// Audio
audio_listener_position(x, y, 0);


if (!instance_exists(Camera)) {
	var cam = instance_create_depth(x, y, depth, Camera);
	cam.target = self;
}


// Debug thingies
if (!Debug) return;

if (keyboard_check(vk_control)) {
	noclip = (mouse_check_button(mb_left));
}

bound_to_room();


