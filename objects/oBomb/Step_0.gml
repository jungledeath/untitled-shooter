// --- 1. COUNTDOWN TIMER ---
life_timer--;

if (life_timer <= 0) 
{
    // Time is up, destroy the item
    instance_destroy();
    return; // Stop reading code so it doesn't try to explode after dying
}

// --- 2. BLINKING EFFECT ---
if (life_timer <= blink_threshold) 
{
    // The modulo (%) operator checks the remainder of division.
    // This toggles the alpha every 6 frames, creating a fast blink.
    if (life_timer % 12 < 6) 
    {
        image_alpha = 0.2; // Almost invisible
    } 
    else 
    {
        image_alpha = 1.0; // Fully solid
    }
}

// --- 3. COLLISION WITH PLAYER (THE EXPLOSION) ---
if (place_meeting(x, y, oPlayer)) 
{
    var _blast_radius = 100; 

    // Loop through ALL targets (Enemies and Spawners)
    with (pTarget) 
    {
        var _dist = point_distance(x, y, other.x, other.y);
        
        // Are they inside the blast zone?
        if (_dist <= _blast_radius) 
        {
            // 1. EVERYONE takes damage and flashes
            hp -= other.bomb_damage;
            hit_flash = 3; 
            
            // 2. ONLY push them if they are NOT spawners
            if (object_index != oSpawner && object_index != oSpawnerB)
            {
                kb_direction = point_direction(other.x, other.y, x, y);
                kb_speed = 8; // We will tweak this once we see the pEnemy code!
            }
        }
    }
    
    // Destroy the bomb
    instance_destroy();
}