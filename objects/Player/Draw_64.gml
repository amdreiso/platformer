
if (!Settings.graphics.drawUI) return;

if (Level.isCutscene) return;

drawGUI();
drawSecretGUI();
drawDeathScreen();

draw_debug_gui();

if (Keymap.player.inventory && !(busy && !inventoryOpen)) {
	inventoryOpen = !inventoryOpen;
	inventory.Sort();
	inventory.itemSelected = -1;
}

if (inventoryOpen) {
	inventory.Draw();
}
