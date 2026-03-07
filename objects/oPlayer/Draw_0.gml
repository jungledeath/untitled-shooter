// If we were just hit, turn the sprite completely solid white
if (hit_flash > 0)
{
    gpu_set_fog(true, c_red, 0, 1);
    draw_self();
    gpu_set_fog(false, c_red, 0, 1); // Turn it back off immediately!
}
else
{
    // Otherwise, draw the tank normally
    draw_self();
}