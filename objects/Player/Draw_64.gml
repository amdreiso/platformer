
if (!Settings.graphics.drawUI) return;

if (Level.isCutscene) return;

drawGUI();
drawSecretGUI();
drawDeathScreen();

draw_debug_gui();

drawMenu();


//if (Keymap.player.map && (!busy || map.open)) {
//	map.open = !map.open;
//	map.size = 30;
//}
//map.size = lerp(map.size, 30, 0.25);
//map.draw();
