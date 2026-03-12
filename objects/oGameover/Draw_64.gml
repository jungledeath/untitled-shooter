var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw the classic red Game Over text
draw_set_color(c_red);
draw_text(_cx, _cy - 20, "GAME OVER");

// Show them their final score
draw_set_color(c_white);
draw_text(_cx, _cy + 20, "FINAL SCORE: " + string(global.player_score));

// Only show the "PRESS OK" prompt after the timer finishes 
// The (current_time mod 1000) math makes it blink like an arcade cabinet!
if (timer <= 0 && (current_time mod 1000) < 500)
{
    draw_set_color(c_yellow);
    if (is_high_score) draw_text(_cx, _cy + 70, "NEW HIGH SCORE! PRESS OK");
    else draw_text(_cx, _cy + 70, "PRESS OK");
}