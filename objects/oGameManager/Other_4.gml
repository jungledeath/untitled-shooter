// Only spawn the game UI if we have actually arrived in the game room
if (room == rLevel1) 
{
    if (!instance_exists(oTouchJoystick)) 
    {
        instance_create_depth(0, 0, 0, oTouchJoystick); 
    }

    if (!instance_exists(oHUD)) 
    {
        instance_create_depth(0, 0, 0, oHUD); 
    }

 
}