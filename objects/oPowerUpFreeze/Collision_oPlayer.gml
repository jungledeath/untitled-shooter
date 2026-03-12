// --- oPowerUpFreeze : Collision with oPlayer ---

// 1. Set the global timer to 300 frames (5 seconds)
global.freeze_timer = 300;

// 2. (BONUS) Create some floating text so they know it activated!
var _text_pop = instance_create_depth(x, y - 20, depth - 100, oFloatingText);
with (_text_pop)
{
    my_text = "FREEZE!"; 
    my_color = c_aqua; 
}

// 3. Destroy the power-up
instance_destroy();