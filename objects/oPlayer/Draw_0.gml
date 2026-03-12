// ==========================================
// DRAW TANK & LASER SIGHT
// ==========================================
// 1. Draw the tank sprite
draw_self();

// 2. Draw the laser line ONLY if the player is actively aiming
if (is_aiming == true)
{
    // Calculate a coordinate 2500 pixels away in the direction the tank is facing
    var _end_x = x + lengthdir_x(2500, image_angle);
    var _end_y = y + lengthdir_y(2500, image_angle);
    
    // Draw the 1-pixel red line from the tank's center to that distant coordinate
    draw_line_color(x, y, _end_x, _end_y, c_red, c_red);
}