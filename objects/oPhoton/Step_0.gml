// --- 1. APPLY FRICTION ---
if (speed > min_speed) 
{
    speed -= fric;
}

// --- 2. CALCULATE RAYCAST NEXT POSITION ---
var _next_x = x + lengthdir_x(speed, direction);
var _next_y = y + lengthdir_y(speed, direction);

// --- 3. CHECK FOR IMPACT ---
// Check for 'pTarget' so it hits both oEnemy and oSpawner!
var _hit = collision_line(x, y, _next_x, _next_y, pTarget, false, true);

if (_hit != noone)
{
    // Deal massive damage (25 damage = 2 hits to destroy a 50 HP spawner)
    _hit.hp -= 25;  
    
    // Check if the target is an enemy that can be pushed back (Spawners don't move!)
    if (variable_instance_exists(_hit, "kb_speed"))
    {
        _hit.kb_speed = 3;             
        _hit.kb_direction = direction;   
        _hit.hit_flash = 3; 
    }

    // Spawn the Visual Spark
    var _spark = instance_create_depth(_hit.x, _hit.y, depth - 1, oExplosion);
    _spark.image_xscale = 0.1; 
    _spark.image_yscale = 0.1;
    
    // Destroy the photon
    instance_destroy();
}