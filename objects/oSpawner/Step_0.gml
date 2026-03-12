// SAFETY CHECK: Don't do any math if the player is dead/missing
if (!instance_exists(oPlayer)) return;

// ==========================================
// 1. SPAWNING LOGIC (CAPPED AT 30)
// ==========================================
if (spawned_count < max_enemies) 
{
    // TICK DOWN THE TIMER
    if (spawn_timer > 0)
    {
        spawn_timer--;
    }
    else
    {
 // 2. CALCULATE SPAWN POSITION 
// Pick a random distance between 30 and 80 pixels away
var _dist = irandom_range(30, 80); 
var _angle = irandom(359);

// Create the variables HERE, before the loop tries to read them!
var _spawn_x = x + lengthdir_x(_dist, _angle);
var _spawn_y = y + lengthdir_y(_dist, _angle);

// ---> THE CRASH FIX: The Escape Hatch <---
var _attempts = 0; 

// Now the loop can safely read _spawn_x and _spawn_y on the very first pass
while (point_distance(_spawn_x, _spawn_y, oPlayer.x, oPlayer.y) < 20 && _attempts < 50)
{
    _angle = irandom(359);
    _spawn_x = x + lengthdir_x(_dist, _angle);
    _spawn_y = y + lengthdir_y(_dist, _angle);
    _attempts++; 
}

// 3. SPAWN THE ALIEN
instance_create_depth(_spawn_x, _spawn_y, depth + 1, oEnemy);
        
        // ---> TICK UP THE COUNTER <---
        spawned_count++; 
        
        // 4. RAMP UP THE AGGRESSION
        if (spawn_rate_current > spawn_rate_min)
        {
            spawn_rate_current -= spawn_rate_decay;
            
            if (spawn_rate_current < spawn_rate_min)
            {
                spawn_rate_current = spawn_rate_min;
            }
        }
        
        // 5. RESET THE TIMER FOR THE NEXT ALIEN
        spawn_timer = spawn_rate_current;
    }
}

// ==========================================
// 6. SPAWNER DESTRUCTION
// ==========================================
if (hp <= 0)
{
    global.player_score += 500;
    // instance_create_depth(x, y, depth, oExplosion); // Optional death effect
    instance_destroy();
}