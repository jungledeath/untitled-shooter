
if (InputPressed(INPUT_VERB.OK)) // Make sure this is Pressed, not Value!
{
    room_goto(rMainMenu);
}

//touch
if (device_mouse_check_button_pressed(0, mb_left))
{
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() - 50; 
    
    var _half_w = 70;
    var _half_h = 17;
    
    if (_mx > _cx - _half_w && _mx < _cx + _half_w && 
        _my > _cy - _half_h && _my < _cy + _half_h)
    {
        room_goto(rMainMenu);
    }
}