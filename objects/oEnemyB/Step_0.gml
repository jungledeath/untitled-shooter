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
        // --- WANDER STATE (Fixed Smooth Steering!) ---
        image_angle += angle_difference(wander_dir, image_angle) * 0.1;
        
        // Move forward based on the newly smoothed angle
        _move_x = lengthdir_x(move_speed, image_angle);
        _move_y = lengthdir_y(move_speed, image_angle);
        
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
        
        // SMOOTH STEERING
        image_angle += angle_difference(_final_dir, image_angle) * 0.1;
        
        // Move forward based on the smoothly rotating angle!
        _move_x = lengthdir_x(move_speed, image_angle);
        _move_y = lengthdir_y(move_speed, image_angle);
    }
}

// ==========================================
// 1.25 APPLY KNOCKBACK (Smooth Sliding)
// ==========================================
if (kb_speed > 0)
{
    var _kb_x = lengthdir_x(kb_speed, kb_direction);
    var _kb_y = lengthdir_y(kb_speed, kb_direction);
    
    _move_x += _kb_x;
    _move_y += _kb_y;
    
    kb_speed -= 1.0; 
    
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
// 2. SWARM SEPARATION (Anti-Clumping)
// ==========================================
var _other_enemy = instance_place(x, y, pEnemy);

if (_other_enemy != noone)
{
    var _push_dir = point_direction(_other_enemy.x, _other_enemy.y, x, y);
    x += lengthdir_x(1, _push_dir);
    y += lengthdir_y(1, _push_dir);
}

// ==========================================
// 3. SHOOTING LOGIC (Now with Freeze Check!)
// ==========================================
// ONLY shoot if the game is NOT frozen!
if (global.freeze_timer <= 0)
{
    if (shoot_timer > 0)
    {
        shoot_timer--;
    }
    else
    {
        // Fire 6 bullets in a perfect circle (0, 60, 120, 180, 240, 300)
        for (var i = 0; i < 360; i += 60)
        {
            var _bullet = instance_create_depth(x, y, depth - 1, oBulletB);
            _bullet.direction = i;
            _bullet.image_angle = i; 
            _bullet.speed = 2.5;     
        }
        
        // Reset the timer for the next burst
        shoot_timer = shoot_timer_max + irandom_range(-30, 60);
    }
}

// --- DEATH CHECK ---
if (hp <= 0)
{
    instance_create_depth(x, y, depth, oExplosion);
    instance_destroy();
}