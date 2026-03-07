// SAFETY CHECK: Don't do any math if the player is dead/missing
if (!instance_exists(oPlayer)) return;

// 1. TICK DOWN THE TIMER
if (spawn_timer > 0)
{
    spawn_timer--;
}
else
{
    // 2. CALCULATE SPAWN POSITION 
    // We create the local variables FIRST so the engine knows what they are!
    var _dist = 30; // How far away from the spawner's center the alien appears
    var _angle = irandom(359);
    var _spawn_x = x + lengthdir_x(_dist, _angle);
    var _spawn_y = y + lengthdir_y(_dist, _angle);
    
    // Safety check: Don't spawn directly on top of the player
    while (point_distance(_spawn_x, _spawn_y, oPlayer.x, oPlayer.y) < 5)
    {
        _angle = irandom(359);
        _spawn_x = x + lengthdir_x(_dist, _angle);
        _spawn_y = y + lengthdir_y(_dist, _angle);
    }

    // 3. SPAWN THE ALIEN
    instance_create_depth(_spawn_x, _spawn_y, depth + 1, oEnemy);
    
    // 4. RAMP UP THE AGGRESSION
    if (spawn_rate_current > spawn_rate_min)
    {
        spawn_rate_current -= spawn_rate_decay;
        
        // Clamp it to the ceiling
        if (spawn_rate_current < spawn_rate_min)
        {
            spawn_rate_current = spawn_rate_min;
        }
    }
    
    // 5. RESET THE TIMER FOR THE NEXT ALIEN
    spawn_timer = spawn_rate_current;
}

// ==========================================
// 6. SPANWER DESTRUCTION
// ==========================================
if (hp <= 0)
{
    global.player_score += 500;
    // instance_create_depth(x, y, depth, oExplosion); // Optional death effect
    instance_destroy();
}