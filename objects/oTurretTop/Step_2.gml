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

// --- NEW: SCAN ALL ENEMY BULLETS (Quantum Anti-Air Priority) ---
with (pEnemyProjectile) 
{
    var _dist = point_distance(x, y, other.x, other.y);
    
    // Is the bullet inside our attack radius?
    if (_dist <= other.attack_range)
    {
        // QUANTUM TRAJECTORY CHECK: The "Cone of Danger"
        // Find the direction from the bullet directly to the player
        var _dir_to_player = point_direction(x, y, oPlayer.x, oPlayer.y);
        
        // Compare that to the direction the bullet is actually flying
        var _angle_diff = abs(angle_difference(direction, _dir_to_player));
        
        // If the bullet is flying within 25 degrees of the player, it's a threat!
        if (_angle_diff <= 25) 
        {
            // Bullets are incredibly dangerous, massive base threat score
            var _base_threat = 5000; 
            var _final_score = _base_threat / max(_dist, 1);
            
            if (_final_score > _best_score)
            {
                _best_score = _final_score;
                _best_target = id; 
            }
        }
    }
}

// 4. AUTO-FIRE & PREDICTIVE AIMING AT THE WINNING TARGET
if (_best_target != noone) 
{
    // --- PREDICTIVE AIMING MATH ---
    // IMPORTANT: Change '15' to whatever speed your oBullet actually travels!
    var _my_bullet_speed = 15; 
    
    // Step A: Calculate time to hit the target's current location
    var _current_dist = point_distance(x, y, _best_target.x, _best_target.y);
    var _time_to_hit = _current_dist / _my_bullet_speed;
    
    // Step B: First prediction (Where will it be?)
    var _predict_x = _best_target.x + lengthdir_x(_best_target.speed * _time_to_hit, _best_target.direction);
    var _predict_y = _best_target.y + lengthdir_y(_best_target.speed * _time_to_hit, _best_target.direction);
    
    // Step C: Second-order refinement for pixel-perfect accuracy
    var _refined_dist = point_distance(x, y, _predict_x, _predict_y);
    var _refined_time = _refined_dist / _my_bullet_speed;
    
    var _final_x = _best_target.x + lengthdir_x(_best_target.speed * _refined_time, _best_target.direction);
    var _final_y = _best_target.y + lengthdir_y(_best_target.speed * _refined_time, _best_target.direction);
    
    // Aim precisely at the predicted interception point
    image_angle = point_direction(x, y, _final_x, _final_y);
    
    // Fire!
    if (fire_timer <= 0)
    {
        with (instance_create_depth(x, y, depth + 1, oBullet))
        {
            speed = _my_bullet_speed; // Guaranteeing the bullet matches the math
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