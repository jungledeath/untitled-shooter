// ==========================================
// 1. DRAW MAIN MENU (Top Left)
// ==========================================
// We will keep the text centered on your start_x coordinate 
// so your touch screen hitboxes still line up perfectly!
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(menu_options); i++)
{
    var _y = start_y + (i * gap);
    
    // Highlight the currently selected option in yellow
    if (i == menu_index)
    {
        draw_set_color(c_yellow); 
    }
    else
    {
        draw_set_color(c_white); 
    }
    
    // Draw the text at our new start_x coordinate (e.g., x=100)
    draw_text(start_x, _y, menu_options[i]);
}

// ==========================================
// 2. DRAW HIGH SCORE LEADERBOARD (Center)
// ==========================================
var _center_x = display_get_gui_width() / 2;
var _score_start_y = 100; 
var _score_gap = 22;      // DECREASED from 35 so all 10 fit!

// Draw a title above the scores (Scaled to 80%)
draw_set_color(c_yellow);
draw_text_transformed(_center_x, _score_start_y - 35, "- TOP PILOTS -", 0.8, 0.8, 0); 

draw_set_color(c_white);

// Safety check
if (variable_global_exists("high_scores")) 
{
    for (var i = 0; i < array_length(global.high_scores); i++)
    {
        var _sy = _score_start_y + (i * _score_gap);
        var _entry = global.high_scores[i];
        
        var _rank = string(i + 1) + ". ";
        var _name = _entry.name;
        var _score = string(_entry.score);
        
        var _display_string = _rank + _name + " ...... " + _score;
        
        // Draw the text at 75% scale so it fits cleanly!
        draw_text_transformed(_center_x, _sy, _display_string, 0.75, 0.75, 0);
    }
}