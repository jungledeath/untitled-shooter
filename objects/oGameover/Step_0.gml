if (timer > 0)
{
    timer--;
}
else 
{
    // Listen for the 'A' button OR a touch screen tap
    if (InputPressed(INPUT_VERB.OK) || device_mouse_check_button_pressed(0, mb_left))
    {
        if (is_high_score == true)
        {
            room_goto(rNameEntry); 
        }
        else
        {
            room_goto(rMainMenu);  
        }
    }
}