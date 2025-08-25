
//collisionTilemap = layer_tilemap_get_id("Collision_Map");

busy = (Paused 
				|| isDead
				|| instance_exists(Textbox) 
				|| instance_exists(PauseMenu) 
				|| Debug.console
);

movement();

applyCollisions();

attack();
handleHealth();
handleBackflip();


// Lighting
viewDistance = viewDistanceDefault * LevelData[? room].components.playerVision;


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







