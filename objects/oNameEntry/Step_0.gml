if (input_cooldown > 0)
{
    input_cooldown--;
}

var _move = InputValue(INPUT_VERB.DOWN) - InputValue(INPUT_VERB.UP);
var _press_ok = InputPressed(INPUT_VERB.OK);

// --- TOUCH SCREEN DETECTION ---
if (device_mouse_check_button_pressed(0, mb_left))
{
    var _my = device_mouse_y_to_gui(0);
    var _cy = display_get_gui_height() / 2;

    // 1. Tap the bottom area: OK Button
    if (_my > _cy + 75) 
    {
        _press_ok = true;
    }
    // 2. Tap the middle-lower area: Scroll Down
    else if (_my > _cy + 30 && _my <= _cy + 75) 
    {
        _move = 1;
    }
    // 3. Tap the upper area: Scroll Up
    else if (_my < _cy) 
    {
        _move = -1;
    }
}

// --- SCROLL THE ALPHABET ---
if (abs(_move) > 0.5 && input_cooldown <= 0)
{
    name_array[current_slot] += sign(_move);
    
    if (name_array[current_slot] >= array_length(alphabet)) name_array[current_slot] = 0;
    if (name_array[current_slot] < 0) name_array[current_slot] = array_length(alphabet) - 1;
    
    input_cooldown = 12; 
}

// --- LOCK IN THE LETTER ---
if (_press_ok)
{
    current_slot++; 
    
    if (current_slot > 2)
    {
        var _final_name = alphabet[name_array[0]] + alphabet[name_array[1]] + alphabet[name_array[2]];
        var _new_entry = { name: _final_name, score: global.player_score };
        
        array_push(global.high_scores, _new_entry);
        
        array_sort(global.high_scores, function(a, b) {
            return b.score - a.score;
        });
        
        array_pop(global.high_scores);
        
        var _json_string = json_stringify(global.high_scores);
        var _file = file_text_open_write("highscores.json");
        file_text_write_string(_file, _json_string);
        file_text_close(_file);
        
        room_goto(rMainMenu);
    }
}