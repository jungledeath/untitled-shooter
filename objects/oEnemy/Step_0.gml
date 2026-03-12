// SAFETY CHECK: Don't do any math if the player is dead/missing
if (!instance_exists(oPlayer)) return;

// We will use these to figure out where the enemy WANTS to go
var _move_x = 0;
var _move_y = 0;

// ==========================================
// 1. THE AI STATE MACHINE (Now with Freeze Check!)
// ==========================================
// ONLY run the AI if the game is NOT frozen!
if (global.freeze_timer <= 0)
{
    if (state == 1) 
    {
        // --- WANDER STATE ---
        _move_x = lengthdir_x(move_speed, wander_dir);
        _move_y = lengthdir_y(move_speed, wander_dir);
        image_angle = wander_dir; 
        
        wander_timer--;
        if (wander_timer <= 0)
        {
            state = 0; 
        }
    }
    else if (state == 0) 
    {
        // --- CHASE STATE (With Flanking) ---
        if (chase_timer > 0) chase_timer--;
        else 
        {
            chase_timer = irandom_range(30, 90); 
            if (random(100) < 25) 
            {
                chase_offset = irandom_range(30, 70) * choose(1, -1);
            }
            else 
            {
                chase_offset = 0; 
            }
        }
        
        var _base_dir = point_direction(x, y, oPlayer.x, oPlayer.y);
        var _final_dir = _base_dir + chase_offset;
        
        _move_x = lengthdir_x(move_speed, _final_dir);
        _move_y = lengthdir_y(move_speed, _final_dir);
        image_angle = _final_dir; 
    }
}

// ==========================================
// 1.25 APPLY KNOCKBACK (Smooth Sliding)
// ==========================================
if (kb_speed > 0)
{
    // Convert the knockback speed and direction into X and Y movement
    var _kb_x = lengthdir_x(kb_speed, kb_direction);
    var _kb_y = lengthdir_y(kb_speed, kb_direction);
    
    // Add the knockback force to the enemy's intended movement
    _move_x += _kb_x;
    _move_y += _kb_y;
    
    // Apply friction! 
    kb_speed -= 1.0; 
    
    // Make sure speed never drops below zero
    if (kb_speed < 0) kb_speed = 0; 
}

// ==========================================
// 1.5. PIXEL PERFECT TANK COLLISIONS 
// ==========================================
// HORIZONTAL
if (place_meeting(x + _move_x, y, oPlayer))
{
    if (_move_x != 0)
    {
        var _dir = sign(_move_x);
        var _limit = ceil(abs(_move_x)) + 1; 
        var _count = 0;
        
        while (!place_meeting(x + _dir, y, oPlayer) && _count < _limit)
        {
            x += _dir;
            _count++;
        }
    }
    _move_x = 0; 
}
x += _move_x; 

// VERTICAL
if (place_meeting(x, y + _move_y, oPlayer))
{
    if (_move_y != 0)
    {
        var _dir = sign(_move_y);
        var _limit = ceil(abs(_move_y)) + 1; 
        var _count = 0;
        
        while (!place_meeting(x, y + _dir, oPlayer) && _count < _limit)
        {
            y += _dir;
            _count++;
        }
    }
    _move_y = 0; 
}
y += _move_y;

// ==========================================
// 2. SWARM SEPARATION (Anti-Clumping Fix!)
// ==========================================
var _other_enemy = instance_place(x, y, pEnemy);

if (_other_enemy != noone)
{
    // Calculate the direction away from the enemy we bumped into
    var _push_dir = point_direction(_other_enemy.x, _other_enemy.y, x, y);
    
    // Gently slide this enemy 1 pixel away so they don't merge into a stuttering blob
    x += lengthdir_x(1, _push_dir);
    y += lengthdir_y(1, _push_dir);
}

// --- DEATH CHECK ---
if (hp <= 0)
{
    instance_create_depth(x, y, depth, oExplosion);
    instance_destroy();
}