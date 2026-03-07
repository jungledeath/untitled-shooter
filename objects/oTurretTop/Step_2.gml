if (!instance_exists(oPlayer)) return;

// 1. FOLLOW THE PLAYER
x = oPlayer.x;
y = oPlayer.y;

// 2. TICK DOWN THE RELOAD TIMER
if (fire_timer > 0) fire_timer--;

// 3. THE THREAT SCANNER (Crowd Control AI)
var _best_target = noone;
var _best_score = -999999; 

// Scan EVERYTHING in the 'pTarget' group
with (pTarget)
{
    var _dist = point_distance(x, y, other.x, other.y);
    
    // Is it inside our attack radius?
    if (_dist <= other.attack_range)
    {
        // --- THREAT RATIO MATH ---
        // Top turret hates fast, high-damage, low-HP targets.
        var _weight_speed = move_speed * 15; 
        var _weight_dmg = damage * 5;
        var _weight_hp = hp * -2; 
        
        var _base_threat = _weight_speed + _weight_dmg + _weight_hp;
        var _final_score = _base_threat / max(_dist, 1);
        
        if (_final_score > _best_score)
        {
            _best_score = _final_score;
            _best_target = id; 
        }
    }
}

// 4. AUTO-FIRE AT THE WINNING TARGET
if (_best_target != noone) 
{
    image_angle = point_direction(x, y, _best_target.x, _best_target.y);
    
    if (fire_timer <= 0)
    {
        with (instance_create_depth(x, y, depth + 1, oBullet))
        {
            direction = other.image_angle;
            image_angle = other.image_angle; 
        }
        
        instance_create_depth(x, y, depth - 1, oFlash);
        fire_timer = fire_rate; 
    }
}
else 
{
    // Rest position when no enemies are around
    image_angle = oPlayer.direction; 
}