
//collisionTilemap = layer_tilemap_get_id("Collision_Map");

busy = (Paused 
		|| isDead
		|| instance_exists(Textbox) 
		|| Paused
		|| Debug.console
		|| menu
		|| resetPosition
);


movement();

attack();
handleHealth();
handleBackflip();


// Check for tiles
tilePosition.x = x div ROOM_TILE_WIDTH;
tilePosition.y = y div ROOM_TILE_HEIGHT;
var xchunk = x div ROOM_TILE_WIDTH;
var ychunk = y div ROOM_TILE_HEIGHT;

if (xchunk != lastChunk.x || ychunk != lastChunk.y || room != lastChunk.roomID) {
	lastChunk.x = xchunk;
	lastChunk.y = ychunk;
	lastChunk.roomID = room;
	
	print($"Discovered new level tile at x: {xchunk} y: {ychunk}");
	map.discover(room, xchunk, ychunk);
}


// Level transitions
levelTransitionCooldown = max(0, levelTransitionCooldown - GameSpeed);


// Lighting
viewDistance = viewDistanceDefault * LevelData[? room].components.playerVision;


// Upgrades
upgrade.update();


// Inventory
inventory.update();


// Audio
audio_listener_position(x, y, 0);


if (!instance_exists(Camera)) {
	var cam = instance_create_depth(x, y, depth, Camera);
	cam.target = self;
}


// Effects
effect_run(self, "update");
effect_apply();




// Apply all collisions
applyCollisions();



// Debug thingies
if (!Debug) return;

if (keyboard_check(vk_control)) {
	noclip = (mouse_check_button(mb_left));
}

bound_to_room();


