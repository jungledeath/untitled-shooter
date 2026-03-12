hp = 100;
spd = .25; // 1 pixel per frame
// --- KNOCKBACK PHYSICS ---
kb_speed = 0;       // How fast they are currently flying backwards
kb_direction = 0;   // Which way they are being pushed
kb_friction = 1.0;  // How quickly they recover their footing (higher = shorter push)
hit_flash = 0; // Tracks if we should flash white
hp = 10;
move_speed = .3 + random_range(-0.1,0.1); // Using move_speed so we don't confuse it with GameMaker's built-in 'speed'
damage = 5;

// --- AI STATE VARIABLES ---
state = 1; // Start in Wander state
wander_dir = irandom(359); // Pick a completely random direction to face

// Pick a random angle (0 to 360 degrees)
wander_dir = random(360); 

// Pick a random wander time between 1.5 seconds (90 frames) and 4 seconds (240 frames)
wander_timer = irandom_range(90, 240);

// --- CHASE VARIATION ---
chase_offset = 0; // How many degrees off-center they are running
chase_timer = 0;  // How long they hold this specific offset path

// --- SHOOTING VARIABLES ---
// Assuming your game runs at 60 Frames Per Second: 60 * 5 = 300 frames
shoot_timer_max = 300; 

// Add a little randomness so multiple EnemyBs don't fire on the exact same frame!
shoot_timer = shoot_timer_max + irandom_range(-30, 60);