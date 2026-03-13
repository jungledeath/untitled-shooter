if (!instance_exists(oPlayer)) return;

// 1. FOLLOW THE PLAYER
x = oPlayer.x;
y = oPlayer.y;

// 2. TICK DOWN THE RELOAD TIMER
if (fire_timer > 0) fire_timer--;

// 3. GET RIGHT STICK INPUT (Aiming)
var _aim_x = 0;
var _aim_y = 0;

if (!InputPlayerUsingTouch())
{
    // If on gamepad/PC, read the right stick
    _aim_x = InputValue(INPUT_VERB.AIM_RIGHT) - InputValue(INPUT_VERB.AIM_LEFT); 
    _aim_y = InputValue(INPUT_VERB.AIM_DOWN) - InputValue(INPUT_VERB.AIM_UP);
}
else if (instance_exists(oTouchJoystick))
{
    // If on touch screen, read the movement stick so the tank fires while driving
    _aim_x = oTouchJoystick.v_joy.GetX();
    _aim_y = oTouchJoystick.v_joy.GetY();
}

// STATE 1: MANUALLY AIMING & FIRING (Stick is Pushed)
if (abs(_aim_x) > 0.3 || abs(_aim_y) > 0.3)
{
    image_angle = point_direction(0, 0, _aim_x, _aim_y);

    if (fire_timer <= 0)
    {
        var _bullet = instance_create_depth(x, y, depth - 10, oPhoton);
        with (_bullet)
        {
            direction = other.image_angle;
            image_angle = other.image_angle;
            speed = 15; 
        }
        fire_timer = fire_rate; 
    }
}
// STATE 2: STICK IS AT REST
else
{
    // No auto-aim and no firing!
    // Just neatly align the turret with the tank's current angle.
    image_angle = oPlayer.image_angle; 
}