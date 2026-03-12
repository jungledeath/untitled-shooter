var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_yellow);
draw_text(_cx, _cy - 80, "NEW RECORD!");
draw_set_color(c_white);
draw_text(_cx, _cy - 40, "ENTER INITIALS:");

var _spacing = 40; 
var _start_x = _cx - _spacing; 

for (var i = 0; i < 3; i++) 
{
    var _letter = alphabet[name_array[i]];
    var _lx = _start_x + (i * _spacing);

    if (i == current_slot) 
    {
        draw_set_color(c_yellow);
        // Draw arrows above and below the currently active slot
        draw_text(_lx, _cy - 15, "^"); 
        draw_text(_lx, _cy + 55, "v"); 
    } 
    else 
    {
        draw_set_color(c_white);
    }

    draw_text(_lx, _cy + 20, _letter);
}

// Draw the OK button at the bottom
draw_set_color(c_white);
draw_text(_cx, _cy + 100, "[ OK ]");