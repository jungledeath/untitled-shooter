// --- ARCADE MOVEMENT VARIABLES ---
move_speed = 0.5; // Or whatever speed feels good. 0.5 is very slow!
boost_speed = 0; // Tracks the extra momentum

// --- HEALTH ---
max_hp = 100;
hp = max_hp;
iframes = 0; // Invincibility frames to prevent instant death

// --- BOOST ENERGY ---
max_boost = 100;
boost_energy = max_boost;
boost_cost = 35;   // Takes a 35% chunk to use the dash
boost_regen = 0.5; // Slowly recharges every frame

// Depth -1 puts it right on top of the hull
turret_bottom = instance_create_depth(x, y, depth - 1, oTurretBottom);

// Depth -2 puts it on top of the bottom turret
turret_top = instance_create_depth(x, y, depth - 2, oTurretTop);

// --- KNOCKBACK & FLASH ---
kb_speed = 0;
kb_direction = 0;
hit_flash = 0;

// --- POWERUPS ---
ghost_mode = false; // Set this to true later when you collect the phase power-up!