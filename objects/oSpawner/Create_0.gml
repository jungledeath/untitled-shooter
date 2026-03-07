

hp = 1500;
move_speed = 0;
damage = 10;

// --- ESCALATING DIFFICULTY ---
spawn_rate_current = 180; // Starts at 3 seconds between spawns
spawn_rate_min = 30;      // The "ceiling" - caps at 0.5 seconds between spawns
spawn_rate_decay = 5;     // Shaves 5 frames off the timer every time it spawns an enemy

// Set the very first countdown
spawn_timer = spawn_rate_current;