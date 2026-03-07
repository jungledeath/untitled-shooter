// Find the exact center of your 600px wide screen
var _center_x = display_get_gui_width() / 2;
var _start_y = display_get_gui_height() / 2;
var _gap = 50; // The 35px button height + 15px of empty space

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw all three options
for (var i = 0; i < array_length(menu_options); i++)
{
    var _y = _start_y + (i * _gap);
    
    // Highlight the currently selected option in yellow
    if (i == menu_index)
    {
        draw_set_color(c_yellow); 
    }
    else
    {
        draw_set_color(c_white); 
    }
    
    // Draw the text
    // NOTE: If you make actual button sprites later, you can replace this line with:
    // draw_sprite(sButton, (i == menu_index), _center_x, _y);
    draw_text(_center_x, _y, menu_options[i]);
}