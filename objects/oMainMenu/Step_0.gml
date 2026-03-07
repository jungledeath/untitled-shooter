// 1. INPUT COOLDOWN
if (input_cooldown > 0) input_cooldown--;

// 2. MENU NAVIGATION (Using your Custom Enums)
// Pushing Down gives 1, Pushing Up gives -1
var _move = InputValue(INPUT_VERB.DOWN) - InputValue(INPUT_VERB.UP);

// Only move if the stick is pushed AND the cooldown is finished
if (abs(_move) > 0.5 && input_cooldown <= 0)
{
    // Move the cursor
    if (_move > 0) menu_index++;
    if (_move < 0) menu_index--;
    
    // Loop the menu around if you go past the top or bottom
    if (menu_index >= array_length(menu_options)) menu_index = 0;
    if (menu_index < 0) menu_index = array_length(menu_options) - 1;
    
    // Lock the input for 15 frames so it moves one slot at a time
    input_cooldown = 15; 
}

// 3. SELECTING AN OPTION
// We use GameMaker's native 'pressed' functions here. 
// This guarantees you don't accidentally double-click and skip past the game intro!
var _select = gamepad_button_check_pressed(0, gp_face1) || keyboard_check_pressed(vk_enter);

if (_select)
{
    switch (menu_index)
    {
        case 0: 
            room_goto(rLevel1); 
            break;
        case 1: 
            room_goto(rSettings); 
            break;
        case 2: 
            room_goto(rCredits); 
            break;
    }
}
// 4. TOUCH SCREEN / MOUSE CLICK DETECTION
// device_mouse_check_button_pressed(0, mb_left) reads the first finger tapping the screen
if (device_mouse_check_button_pressed(0, mb_left))
{
    // Get the exact GUI coordinates of the tap
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // The exact same layout math from our Draw GUI event
    var _center_x = display_get_gui_width() / 2;
    var _start_y = display_get_gui_height() / 2;
    var _gap = 50; 
    
    // Your button dimensions (140px wide, 35px tall)
    var _half_w = 70;  // Half of 140
    var _half_h = 17;  // Half of 35
    
    // Check every button to see if the tap landed inside its invisible box
    for (var i = 0; i < array_length(menu_options); i++)
    {
        var _by = _start_y + (i * _gap);
        
        // Is the tap inside the Left/Right and Top/Bottom boundaries of this button?
        if (_mx > _center_x - _half_w && _mx < _center_x + _half_w && 
            _my > _by - _half_h && _my < _by + _half_h)
        {
            // Tap successful! Update the visual highlight
            menu_index = i; 
            
            // Execute the button press
            switch (menu_index)
            {
                case 0: 
                    room_goto(rLevel1); 
                    break;
                case 1: 
                    room_goto(rSettings); 
                    break;
                case 2: 
                    room_goto(rCredits); 
                    break;
            }
        }
    }
}