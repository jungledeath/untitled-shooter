if (!instance_exists(oPlayer)) return; 

// 1. Calculate the percentages (0 to 100)
var _hp_pc = (oPlayer.hp / oPlayer.max_hp) * 100;
var _boost_pc = (oPlayer.boost_energy / oPlayer.max_boost) * 100;

// 2. Setup our HUD layout variables
var _start_x = 20;       // 20 pixels from the left edge of the screen
var _start_y = 20;       // 20 pixels down from the top edge
var _bar_width = 100;    // Both bars will be 100 pixels wide
var _bar_height = 10;    // Both bars will be 10 pixels thick
var _gap = 10;           // Exactly 10 pixels of empty space between them

// 3. Draw Health Bar (Top)
var _hp_y2 = _start_y + _bar_height; 
draw_healthbar(_start_x, _start_y, _start_x + _bar_width, _hp_y2, _hp_pc, c_black, c_red, c_green, 0, true, true);

// 4. Draw Boost Bar (Directly underneath)
var _boost_y1 = _hp_y2 + _gap; // Starts exactly 10 pixels below the health bar
var _boost_y2 = _boost_y1 + _bar_height;
draw_healthbar(_start_x, _boost_y1, _start_x + _bar_width, _boost_y2, _boost_pc, c_black, c_red, c_aqua, 0, true, true);

// 3. DRAW THE FRAME OVERLAY LAST
// Adjust the "- 5" offset based on exactly how thick you drew your border!
draw_sprite(sHudFrame, 0, _start_x - 5, _start_y - 5);

// --- DRAW THE SCORE ---
// Set the text color to white
draw_set_color(c_white);

// Align the text to be perfectly centered
draw_set_halign(fa_center);

// Draw the score in the top-middle of the screen
var _screen_center = display_get_gui_width() / 2;
draw_text(_screen_center, 20, "SCORE: " + string(global.player_score));

// Reset the alignment back to normal so we don't accidentally mess up other text later!
draw_set_halign(fa_left);