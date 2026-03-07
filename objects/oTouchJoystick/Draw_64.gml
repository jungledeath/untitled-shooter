// --- 0. GAMEPAD CHECK (The Input Library Way) ---
// This uses your specific version's script to check if Player 0 (you) is using a gamepad.
if (InputPlayerUsingGamepad(0)) return;

// --- 1. GET JOYSTICK POSITIONS ---
var _pos = v_joy.GetPosition();

// Safety Net: If the stick is still initializing on frame 1, don't crash!
if (_pos == undefined) return; 

// --- 2. DRAW JOYSTICK ---
// Draw the base static in its corner
draw_sprite(sJoyBase, 0, _pos.x, _pos.y);

// Calculate the moving thumbstick
var _visual_radius = radius - (sprite_get_width(sJoyThumb) / 2); 
var _stick_x = _pos.x + (v_joy.GetX() * _visual_radius);
var _stick_y = _pos.y + (v_joy.GetY() * _visual_radius);

// Draw the thumbstick handle
draw_sprite(sJoyThumb, 0, _stick_x, _stick_y);

// --- 3. DRAW BOOST BUTTON ---
var _boost_pos = v_boost.GetPosition();

if (v_boost.Check()) 
{
    // Draw slightly darker when pressed
    draw_sprite_ext(sBoost, 0, _boost_pos.x, _boost_pos.y, 1, 1, 0, c_gray, 1);
}
else
{
    // Draw normally
    draw_sprite(sBoost, 0, _boost_pos.x, _boost_pos.y);
}