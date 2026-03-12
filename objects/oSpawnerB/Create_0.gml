hp = 800;
move_speed = 0;
damage = 10;

// --- ESCALATING DIFFICULTY ---
spawn_rate_current = 180; // Starts at 3 seconds between spawns
spawn_rate_min = 30;      // The "ceiling" - caps at 0.5 seconds between spawns
spawn_rate_decay = 5;     // Shaves 5 frames off the timer every time it spawns an enemy

// Add between 0 and 2 seconds (120 frames) of random delay to the VERY FIRST spawn.
// This ensures multiple spawners in the same room fire off-beat from each other.
spawn_timer = spawn_rate_current + irandom_range(400, 800);

// Capping the spawner
max_enemies = 30;  // The total number we want to spawn
spawned_count = 0; // How many we have spawned so far