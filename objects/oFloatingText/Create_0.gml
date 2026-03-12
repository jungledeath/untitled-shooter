// --- ANIMATION SETUP (Assuming 60 FPS) ---

// 1. Vertical Speed: Start moving UP fast, then slow down naturally.
vspeed = -4;        // Built-in GM variable. Negative moves up.
friction = 0.1;     // Built-in friction makes the rise "smooth" and slower.

// 2. Fading Variables
my_alpha = 1.0;     // Total visibility
fade_speed = 0.017; // Subtracting this per frame means total fade in 60 frames.

// 3. Text Placeholders (Will be set by the Enemy when created)
my_text = "";
my_color = c_white;