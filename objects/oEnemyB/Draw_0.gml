if (hit_flash > 0)
{
    // Turn on GameMaker's pure-white fog
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
    
    // Tick down the flash timer
    hit_flash--;
}
else
{
    // Draw normally
    draw_self();
}