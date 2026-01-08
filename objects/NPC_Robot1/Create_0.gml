
event_inherited();

dialogue = [
	"[shake=0.25]bzzt... bzzt...[/shake]",
];

talkingSprite = sRobot1_talking;

alarm[0] = 1;

offset.y = -sprite_get_height(sprite_index);

itemToFix = ITEM_ID.ScrapElectronics;
destroyed = false;

isFixed = SaveState.progression.cave_entrance.robot_0.isFixed;
