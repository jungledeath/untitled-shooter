// If the player is pushing the right stick, draw the crosshair
if (is_manual == true)
{
    // Calculate a spot 40 pixels away in the direction we are aiming
    var _cross_x = x + lengthdir_x(40, image_angle);
    var _cross_y = y + lengthdir_y(40, image_angle);
    
    // Draw the targeting reticle
    draw_sprite(sCrosshair, 0, _cross_x, _cross_y);
}