attack_range = 300; // How far they can see
fire_rate = 15;     // How many frames to wait between shots (60 = 1 second)
fire_timer = 0;     // The actual stopwatch that ticks down
is_manual = false; // Tracks if the gamepad is being used

// --- AI TARGETING PROTOCOLS ---
target_mode = 0;   // Starts in Mode 0
max_modes = 3;     // Total number of targeting modes we have