// ==========================================
// 1. MANAGE INPUT COOLDOWN
// ==========================================
if (input_cooldown > 0)
{
    input_cooldown--;
}

// ==========================================
// 2. MENU NAVIGATION (Stick / D-Pad)
// ==========================================
// Check if the player is pushing Up or Down
var _move = InputValue(INPUT_VERB.DOWN) - InputValue(INPUT_VERB.UP);

// ONLY allow movement if the stick is pushed AND the cooldown is finished
if (abs(_move) > 0.5 && input_cooldown <= 0)
{
    // Move the cursor
    if (_move > 0) menu_index++;
    if (_move < 0) menu_index--;
    
    // Loop the menu around automatically based on the number of options
    if (menu_index >= array_length(menu_options)) menu_index = 0;
    if (menu_index < 0) menu_index = array_length(menu_options) - 1;
    
    // Lock the input for 15 frames to prevent rapid scrolling
    input_cooldown = 15; 
}

// ==========================================
// 3. SELECTION DETECTION (Gamepad, Keyboard & Touch)
// ==========================================
var _select = false;

// Check Gamepad / Keyboard via Input (Single Tap to prevent room bouncing!)
if (InputPressed(INPUT_VERB.OK))
{
    _select = true;
}

// Check Touch Screen / Mouse
if (device_mouse_check_button_pressed(0, mb_left))
{
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // Use the variables from your Create Event instead of screen center!
    var _bx = start_x; 
    var _by_start = start_y;
    var _gap = gap; 
    
    // Slightly smaller hitboxes for the smaller buttons
    var _half_w = 60; // (used to be 70)
    var _half_h = 15; // (used to be 17)
    
    for (var i = 0; i < array_length(menu_options); i++)
    {
        var _by = _by_start + (i * _gap);
        
        if (_mx > _bx - _half_w && _mx < _bx + _half_w && 
            _my > _by - _half_h && _my < _by + _half_h)
        {
            menu_index = i; 
            _select = true; 
        }
    }
}

// ==========================================
// 4. EXECUTE THE TRANSITION
// ==========================================
// Execute the room change based on where the cursor is pointing
if (_select)
{
    switch (menu_index)
    {
        case 0: 
            global.player_score = 0; // Reset score right before the game starts!
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