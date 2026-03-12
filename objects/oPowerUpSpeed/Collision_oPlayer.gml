// --- oPowerUpSpeed : Collision with oPlayer ---

// 1. Set the global timer to 300 frames (5 seconds)
global.speed_timer = 300;

// 2. Create some floating text so they know it activated!
var _text_pop = instance_create_depth(x, y - 20, depth - 100, oFloatingText);
with (_text_pop)
{
    my_text = "SPEED UP!"; 
    my_color = c_yellow; 
}

// 3. Destroy the power-up
instance_destroy();