// --- 1. SLOW DOWN TO CRUISING SPEED ---
if (speed > min_speed) 
{
    speed -= fric;
}

// --- 2. CALCULATE RAYCAST NEXT POSITION ---
var _next_x = x + lengthdir_x(speed, direction);
var _next_y = y + lengthdir_y(speed, direction);

// --- 3. CHECK FOR ENEMY HIT ---
var _enemy_hit = collision_line(x, y, _next_x, _next_y, pTarget, false, true);

if (_enemy_hit != noone)
{
    // Hurt and push the enemy
    _enemy_hit.hp -= 5;  
    _enemy_hit.kb_speed = 1.5;             
    _enemy_hit.kb_direction = direction;   
    _enemy_hit.hit_flash = 3; 

    // Visual Spark
    var _spark = instance_create_depth(_enemy_hit.x, _enemy_hit.y, depth - 1, oExplosion);
    _spark.image_xscale = 0.05; 
    _spark.image_yscale = 0.05;
    
    // Destroy bullet and stop reading code
    instance_destroy();
    return; 
}

// --- 4. CHECK FOR SPAWNER HIT ---
var _spawner_hit = collision_line(x, y, _next_x, _next_y, oSpawner, false, true);

if (_spawner_hit != noone)
{
    // Hurt the spawner (We do NOT push it because it is a building)
    _spawner_hit.hp -= 5;  
    
    // Visual Spark
    var _spark = instance_create_depth(_spawner_hit.x, _spawner_hit.y, depth - 1, oExplosion);
    _spark.image_xscale = 0.05; 
    _spark.image_yscale = 0.05;
    
    // Destroy bullet
    instance_destroy();
}

// --- 5. CHECK FOR ENEMY BULLET HIT (ANTI-AIR) ---
// Draw a line to see if we hit ANY incoming enemy projectile
var _bullet_hit = collision_line(x, y, _next_x, _next_y, pEnemyProjectile, false, true);

if (_bullet_hit != noone)
{
    // Vaporize the enemy bullet!
    instance_destroy(_bullet_hit);
    
    // Bonus points for intercepting a shot
    global.player_score += 10; 
    
    // Destroy our player bullet and stop reading code
    instance_destroy();
    return; 
}