if (!instance_exists(oPlayer)) return;

// 1. FOLLOW THE PLAYER
x = oPlayer.x;
y = oPlayer.y;

// 2. TICK DOWN THE RELOAD TIMER
if (fire_timer > 0) fire_timer--;

// 3. GET RIGHT STICK INPUT (Aiming)
var _aim_x = InputValue(INPUT_VERB.AIM_RIGHT) - InputValue(INPUT_VERB.AIM_LEFT); 
var _aim_y = InputValue(INPUT_VERB.AIM_DOWN) - InputValue(INPUT_VERB.AIM_UP);

if (InputPlayerUsingTouch() && instance_exists(oTouchJoystick)) 
{
    _aim_x = oTouchJoystick.v_joy.GetX();
    _aim_y = oTouchJoystick.v_joy.GetY();
}

// STATE 1: MANUALLY AIMING (Stick or Touch is Pushed)
if (abs(_aim_x) > 0.3 || abs(_aim_y) > 0.3)
{
    // Point the turret exactly where the stick is tilted
    image_angle = point_direction(0, 0, _aim_x, _aim_y);

    // Continuous fire
    if (fire_timer <= 0)
    {
        with (instance_create_depth(x, y, depth + 1, oPhoton))
        {
            direction = other.image_angle;
            image_angle = other.image_angle;
        }
        fire_timer = fire_rate; 
    }
}
// STATE 2: STICK IS AT REST (Auto-Fire Mode)
else
{
    var _best_target = noone;
    var _best_score = -999999; 
     

    // Scan EVERYTHING in the 'pTarget' group
    with (pTarget)
    {
        var _dist = point_distance(x, y, other.x, other.y);
        
        if (_dist <= other.attack_range)
        {
            var _weight_hp = hp * 10; 
            var _weight_dmg = damage * 15;
            var _weight_speed = move_speed * 2; 
            
            var _base_threat = _weight_hp + _weight_dmg + _weight_speed;
            var _final_score = _base_threat / max(_dist, 1);
            
            if (_final_score > _best_score)
            {
                _best_score = _final_score;
                _best_target = id; 
            }
        }
    }
    
    // AUTO-FIRE AT THE WINNING TARGET
    if (_best_target != noone) 
    {
        image_angle = point_direction(x, y, _best_target.x, _best_target.y);
        
        if (fire_timer <= 0)
        {
            with (instance_create_depth(x, y, depth + 1, oPhoton))
            {
                direction = other.image_angle;
                image_angle = other.image_angle; 
            }
            fire_timer = fire_rate; 
        }
    }
    else 
    {
        // Rest position when no enemies are around
        image_angle = oPlayer.image_angle; 
    }
}