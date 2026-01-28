
if (!Settings.graphics.drawUI) return;

if (Level.isCutscene) return;

drawGUI();
drawSecretGUI();
drawDeathScreen();

draw_debug_gui();


draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text_outline(0, HEIGHT, $"{GameInfo.name} {GameInfo.version.major}.{GameInfo.version.minor} {GameInfo.build}", 1, 1, 0, 1, fnt_main);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);


if (Keymap.player.inventory && !(busy && !inventoryOpen)) {
	inventoryOpen = !inventoryOpen;
	inventory.CloseGUI();
}

if (inventoryOpen) {
	inventory.Draw();
}

