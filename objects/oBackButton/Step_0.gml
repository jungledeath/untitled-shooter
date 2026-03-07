// 1. PHYSICAL BUTTONS (Escape Key or Gamepad 'B' Button)
if (keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_face2))
{
    room_goto(rMainMenu);
}

// 2. TOUCH SCREEN / MOUSE CLICK
if (device_mouse_check_button_pressed(0, mb_left))
{
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // Position: Center horizontally, 50 pixels up from the bottom of the screen
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() - 50; 
    
    // Button Hitbox (140px wide, 35px tall)
    var _half_w = 70;
    var _half_h = 17;
    
    // Did the tap land inside the hitbox?
    if (_mx > _cx - _half_w && _mx < _cx + _half_w && 
        _my > _cy - _half_h && _my < _cy + _half_h)
    {
        room_goto(rMainMenu);
    }
}