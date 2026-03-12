//collision
if (place_meeting(x, y, oPlayer))
{
    if (oPlayer.iframes <= 0)
    {
        oPlayer.hp -= 10; // Or whatever damage you want
        oPlayer.hit_flash = 5; 
        oPlayer.iframes = 60; 
    }
    instance_destroy(); 
}