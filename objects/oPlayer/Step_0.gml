// ==========================================
// 1. GET INPUT (Gamepad, Keyboard, or Touch)
// ==========================================
var _input_x = 0;
var _input_y = 0;

if (InputPlayerUsingTouch() && instance_exists(oTouchJoystick)) 
{
    _input_x = oTouchJoystick.v_joy.GetX();
    _input_y = oTouchJoystick.v_joy.GetY();
}
else 
{
    _input_x = InputValue(INPUT_VERB.RIGHT) - InputValue(INPUT_VERB.LEFT);
    _input_y = InputValue(INPUT_VERB.DOWN) - InputValue(INPUT_VERB.UP);
}

// ==========================================
// 2. BOOST LOGIC
// ==========================================
if (InputValue(INPUT_VERB.BOOST) > 0.5 && boost_speed == 0 && boost_energy >= boost_cost)
{
    boost_speed = 4.5; 
    boost_energy -= boost_cost;
}

if (boost_energy < max_boost) 
{
    boost_energy += boost_regen;
    boost_energy = min(boost_energy, max_boost); 
}

if (boost_speed > 0)
{
    boost_speed -= 0.20; 
    boost_speed = max(0, boost_speed); 
}

// ==========================================
// 3. MOVEMENT & SPEED POWER-UP
// ==========================================
var _speed_multiplier = 1; 

if (global.speed_timer > 0)
{
    _speed_multiplier = 1.5; // Increases speed by 50%
    global.speed_timer--; 
}

// Calculate base movement based on input and multiplier
var _hsp = (_input_x * move_speed) * _speed_multiplier;
var _vsp = (_input_y * move_speed) * _speed_multiplier;

// Add the boost momentum in the direction the tank is facing
_hsp += lengthdir_x(boost_speed, image_angle);
_vsp += lengthdir_y(boost_speed, image_angle);
// ==========================================
// AIMING & ROTATION
// ==========================================
is_aiming = false; 

// 1. Get raw aim input from the right stick
var _aim_x = InputValue(INPUT_VERB.AIM_RIGHT) - InputValue(INPUT_VERB.AIM_LEFT);
var _aim_y = InputValue(INPUT_VERB.AIM_DOWN) - InputValue(INPUT_VERB.AIM_UP);

// 2. ONLY change angle and turn on laser IF actively pushing the stick
if (abs(_aim_x) > 0.2 || abs(_aim_y) > 0.2)
{
    image_angle = point_direction(0, 0, _aim_x, _aim_y);
    is_aiming = true;
}

// 3. Pin the crosshair strictly to the tank so it never gets left behind
if (instance_exists(oCrosshair))
{
    oCrosshair.x = x + lengthdir_x(150, image_angle);
    oCrosshair.y = y + lengthdir_y(150, image_angle);
}
// 4. TANK ROTATION LOGIC
if (InputPlayerUsingTouch() && instance_exists(oTouchJoystick))
{
    // ON MOBILE: Read the raw analog decimal values directly from the joystick
    // This provides a full 360 degrees of smooth rotation instead of 8 locked directions
    var _move_x = oTouchJoystick.v_joy.GetX();
    var _move_y = oTouchJoystick.v_joy.GetY();
    
    if (abs(_move_x) > 0.2 || abs(_move_y) > 0.2)
    {
        image_angle = point_direction(0, 0, _move_x, _move_y);
    }
}
else if (instance_exists(oCrosshair))
{
    // ON PC/CONSOLE: Tank rotates to face the crosshair
    image_angle = point_direction(x, y, oCrosshair.x, oCrosshair.y);
}

// ==========================================
// 0. ANTI-OVERLAP (Fixes Sticky Collisions)
// ==========================================
// If an enemy gets pushed inside the tank, gently nudge the tank out 
// so it doesn't get permanently paralyzed!
var _stuck = instance_place(x, y, pTarget);
if (_stuck != noone)
{
    var _push_dir = point_direction(_stuck.x, _stuck.y, x, y);
    x += lengthdir_x(1, _push_dir);
    y += lengthdir_y(1, _push_dir);
}

// ==========================================
// 1. SOLID COLLISIONS (Freeze-Proof Spalding)
// ==========================================
if (ghost_mode == false)
{
    // HORIZONTAL
    if (place_meeting(x + _hsp, y, pTarget))
    {
        if (_hsp != 0) 
        {
            var _dir = sign(_hsp);
            var _limit = ceil(abs(_hsp)) + 1; // Safety limit!
            var _count = 0;
            
            while (!place_meeting(x + _dir, y, pTarget) && _count < _limit)
            {
                x += _dir;
                _count++;
            }
        }
        _hsp = 0; 
    }
    x += _hsp; 

    // VERTICAL
    if (place_meeting(x, y + _vsp, pTarget))
    {
        if (_vsp != 0)
        {
            var _dir = sign(_vsp);
            var _limit = ceil(abs(_vsp)) + 1; // Safety limit!
            var _count = 0;
            
            while (!place_meeting(x, y + _dir, pTarget) && _count < _limit)
            {
                y += _dir;
                _count++;
            }
        }
        _vsp = 0; 
    }
    y += _vsp; 
}
else
{
    x += _hsp;
    y += _vsp;
}

// --- 1. TICK DOWN TIMERS ---
if (iframes > 0) iframes--;
if (hit_flash > 0) hit_flash--; 

// --- 2. CHECK FOR HAZARD COLLISION (Taking Damage) ---
var _hazard = instance_place(x, y, pTarget);

if (_hazard != noone && iframes <= 0)
{
    hp -= _hazard.damage; 
    hit_flash = 5; 
    
    // NOTE: Knockback removed here! 
    // The tank will no longer hiccup backward when touching an alien.

    iframes = 60; 
}

// --- 3. APPLY EXPLOSION KNOCKBACK PHYSICS ---
// This is untouched! If a separate bomb object sets kb_speed > 0, 
// the tank will still get pushed by the explosion.
if (kb_speed > 0)
{
    // Note: We don't collision-check knockback here so explosions 
    // can forcefully shove the tank through crowds if needed.
    x += lengthdir_x(kb_speed, kb_direction);
    y += lengthdir_y(kb_speed, kb_direction);
    kb_speed -= 0.5; 
}
else
{
    kb_speed = 0; 
}

// ==========================================
// KEEP PLAYER INSIDE THE ROOM (ON-SCREEN)
// ==========================================
var _margin_x = sprite_width / 2;
var _margin_y = sprite_height / 2;

x = clamp(x, _margin_x, room_width - _margin_x);
y = clamp(y, _margin_y, room_height - _margin_y);

// --- COMBO TIMER TICK DOWN ---
if (global.combo_timer > 0) 
{
    global.combo_timer--;
    
    if (global.combo_timer <= 0) 
    {
        // Time ran out! Combo broken.
        global.combo_count = 0; 
    }
}
// --- 4. DID WE DIE? ---
if (hp <= 0)
{
    // 1. Clean up the attached turrets
    if (instance_exists(turret_bottom)) instance_destroy(turret_bottom);
    if (instance_exists(turret_top)) instance_destroy(turret_top);
    
    // 2. Destroy the tank itself
    instance_destroy(); 
    
    // 3. Send them to the Game Over screen so it can check their final score!
    room_goto(rGameOver); 
}