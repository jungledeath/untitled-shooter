if (!instance_exists(oPlayer)) return;

// ==========================================
// 1. THE AI STATE MACHINE
// ==========================================
if (state == 1) 
{
    // --- WANDER STATE ---
    // Move in our random direction
    x += lengthdir_x(move_speed, wander_dir);
    y += lengthdir_y(move_speed, wander_dir);
    image_angle = wander_dir; 
    
    // Tick down the timer
    wander_timer--;
    
    // Once the timer hits 0, switch to Chase Mode!
    if (wander_timer <= 0)
    {
        state = 0; 
    }
}
else if (state == 0) 
{
    // --- CHASE STATE (With Flanking Variation) ---
    
    // 1. Tick down the offset timer
    if (chase_timer > 0) chase_timer--;
    else 
    {
        // Time to pick a new path! Hold this new path for 0.5 to 1.5 seconds.
        chase_timer = irandom_range(30, 90); 
        
        // 25% chance to break off, 75% chance to run dead straight
        if (random(100) < 25) 
        {
            // Pick a random angle between 30 and 70 degrees, then randomly choose Left or Right
            chase_offset = irandom_range(30, 70) * choose(1, -1);
        }
        else 
        {
            // Run straight at the player
            chase_offset = 0; 
        }
    }
    
    // 2. Lock onto the player, but ADD the offset variation!
    var _base_dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    var _final_dir = _base_dir + chase_offset;
    
    // Move using the newly calculated imperfect angle
    x += lengthdir_x(move_speed, _final_dir);
    y += lengthdir_y(move_speed, _final_dir);
    
    // Look the way we are walking
    image_angle = _final_dir; 
}

// ==========================================
// 2. SWARM SEPARATION (Anti-Clumping)
// ==========================================
// Check if we are bumping into another enemy
var _other_enemy = instance_place(x, y, oEnemy);

if (_other_enemy != noone)
{
    // Find the direction AWAY from the enemy we are touching
    var _push_dir = point_direction(_other_enemy.x, _other_enemy.y, x, y);
    
    // Gently slide away by 1 pixel so we don't stack perfectly on top of them
    x += lengthdir_x(1, _push_dir);
    y += lengthdir_y(1, _push_dir);
}
// --- DEATH CHECK ---
if (hp <= 0)
{
    global.player_score += 100;
    
    // Spawn the death sequence
    instance_create_depth(x, y, depth, oExplosion);
    
    // Destroy the enemy
    instance_destroy();
}