draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(my_color);

// If we don't specify a scale, default it to 1 (normal size)
if (!variable_instance_exists(id, "my_scale")) 
{
    my_scale = 1; 
}

// Draw the text using the scale variable
draw_text_transformed(x, y, my_text, my_scale, my_scale, 0);