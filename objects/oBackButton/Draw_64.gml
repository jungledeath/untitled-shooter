// Position: Center horizontally, 50 pixels up from the bottom
var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() - 50; 

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

// Draw the text
// (If you make a Back button sprite later, swap this for draw_sprite)
draw_text(_cx, _cy, "BACK");