
if (!Settings.graphics.drawUI) return;

if (Level.isCutscene) return;

drawGUI();
drawSecretGUI();
drawDeathScreen();

draw_debug_gui();


if (Keymap.player.map) {
	map.open = !map.open;
	map.size = 30;
}
map.size = lerp(map.size, 20, 0.25);
map.draw();
