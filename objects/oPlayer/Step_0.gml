var _x = 0;
var _y = 0;

if (InputPlayerUsingTouch()) 
{
    if (instance_exists(oTouchJoystick)) 
    {
        _x = oTouchJoystick.v_joy.GetX();
        _y = oTouchJoystick.v_joy.GetY();
    }
}
else 
{
    _x = InputValue(INPUT_VERB.RIGHT) - InputValue(INPUT_VERB.LEFT);
    _y = InputValue(INPUT_VERB.DOWN) - InputValue(INPUT_VERB.UP);
}

// --- BOOST TRIGGER ---
// Check if button is pressed, we aren't already boosting, AND we have enough energy
if (InputValue(INPUT_VERB.BOOST) > 0.5 && boost_speed == 0 && boost_energy >= boost_cost)
{
    boost_speed = 4.5; 
    boost_energy -= boost_cost; // Deduct the cost!
}

// --- BOOST REGEN ---
// Slowly fill the bar back up when not full
if (boost_energy < max_boost) 
{
    boost_energy += boost_regen;
    // Prevent it from going over 100
    boost_energy = min(boost_energy, max_boost); 
}

// --- BOOST FADE (FRICTION) ---
if (boost_speed > 0)
{
    boost_speed -= 0.15; 
    boost_speed = max(0, boost_speed); 
}

// --- BOOST FADE (FRICTION) ---
if (boost_speed > 0)
{
    boost_speed -= 0.20; // Slowly fades out
    boost_speed = max(0, boost_speed); // Stops exactly at 0
}

// --- MOVEMENT MATH ---
var _mag = 0;

if (abs(_x) > 0.1 || abs(_y) > 0.1) 
{
    var _dir = point_direction(0, 0, _x, _y);
    image_angle = _dir; // Face the direction we are pushing
    _mag = clamp(point_distance(0, 0, _x, _y), 0, 1);
}

// Combine your base speed with the current boost momentum
var _total_speed = (move_speed * _mag) + boost_speed;

if (_total_speed > 0)
{
    // We use image_angle so the tank can boost forward 
    // even if you let go of the movement stick!
    x += lengthdir_x(_total_speed, image_angle);
    y += lengthdir_y(_total_speed, image_angle);
}
// --- 1. TICK DOWN TIMERS ---
if (iframes > 0) iframes--;
if (hit_flash > 0) hit_flash--; 

// --- 2. CHECK FOR HAZARD COLLISION (Enemies AND Spawners) ---
// Now we check for the entire pTarget family!
var _hazard = instance_place(x, y, pTarget);

if (_hazard != noone && iframes <= 0)
{
    // Take damage based on exactly what we hit
    hp -= _hazard.damage; 
    hit_flash = 5; 
    
    // The Hiccup
    kb_direction = point_direction(_hazard.x, _hazard.y, x, y);
    kb_speed = 3; 

    // Invincibility frames
    iframes = 60; 
}

// --- 3. APPLY KNOCKBACK PHYSICS ---
if (kb_speed > 0)
{
    x += lengthdir_x(kb_speed, kb_direction);
    y += lengthdir_y(kb_speed, kb_direction);
    kb_speed -= 0.5; 
}
else
{
    kb_speed = 0; 
}

// --- 4. SOLID COLLISIONS (Cannot pass through pTarget) ---
if (ghost_mode == false)
{
    // Check if we are physically inside an enemy or spawner
    var _blocker = instance_place(x, y, pTarget);
    if (_blocker != noone)
    {
        var _push_dir = point_direction(_blocker.x, _blocker.y, x, y);
        var _push_count = 0; 
        
        // Push the tank out 1 pixel at a time until it's no longer inside!
        // (Capped at 15 times per frame so GameMaker doesn't crash if you get cornered)
        while (place_meeting(x, y, _blocker) && _push_count < 15)
        {
            x += lengthdir_x(1, _push_dir);
            y += lengthdir_y(1, _push_dir);
            _push_count++;
        }
    }
}

// --- 5. DID WE DIE? ---
if (hp <= 0)
{
    room_restart(); 
}