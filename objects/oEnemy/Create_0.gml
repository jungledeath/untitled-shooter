hp = 100;
spd = .25; // 1 pixel per frame
// --- KNOCKBACK PHYSICS ---
kb_speed = 0;       // How fast they are currently flying backwards
kb_direction = 0;   // Which way they are being pushed
kb_friction = 1.0;  // How quickly they recover their footing (higher = shorter push)
hit_flash = 0; // Tracks if we should flash white
hp = 10;
move_speed = .3; // Using move_speed so we don't confuse it with GameMaker's built-in 'speed'
damage = 5;

// --- AI STATE MACHINE ---
// state 0 = Chasing the player
// state 1 = Wandering randomly
state = choose(0, 1, 1); // 33% chance to chase immediately, 66% chance to wander

// Pick a random angle (0 to 360 degrees)
wander_dir = random(360); 

// Pick a random time to wander (between 0.5 seconds and 2 seconds)
wander_timer = irandom_range(30, 120);

// --- CHASE VARIATION ---
chase_offset = 0; // How many degrees off-center they are running
chase_timer = 0;  // How long they hold this specific offset path