
if (!Settings.graphics.drawUI) return;

if (Level.isCutscene) return;

drawGUI();
drawSecretGUI();
drawDeathScreen();

draw_debug_gui();

if (Keymap.player.inventory && !(busy && !inventoryOpen)) {
	inventoryOpen = !inventoryOpen;
}

if (inventoryOpen) {
	inventory.Draw();
}
