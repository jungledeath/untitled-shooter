// This tells the game: "Run the bomb-drop code from pTarget first."
event_inherited();

// ==========================================
// 2. UNLIMITED PROGRESSIVE COMBO SYSTEM
// ==========================================
var _base_score = 100;
var _combo_bonus = 0;

global.combo_count++;

// 0.25 SECOND WINDOW! (15 frames at 60 FPS)
global.combo_timer = 15; 

// The Uncapped Math
if (global.combo_count <= 7) 
{
    // Kills 1-7: +10 per level
    _combo_bonus = global.combo_count * 10; 
} 
else if (global.combo_count <= 14) 
{
    // Kills 8-14: +50 per level
    _combo_bonus = global.combo_count * 50; 
} 
else 
{
    // Kills 15 to Infinity: +100 per level, NO CAP.
    _combo_bonus = global.combo_count * 100; 
}

// Grant the final calculated score
var _final_points = _base_score + _combo_bonus;
global.player_score += _final_points;

// ==========================================
// 3. SPAWN THE COMBO TEXT (Starts at x6)
// ==========================================
// 1. Calculate a "random" hue based on the combo number.
// Multiplying by 47 (a prime number) forces the color to jump sharply across the spectrum.
// 'mod 255' safely wraps the number back around so it never breaks the color wheel.
var _hue = (global.combo_count * 47) mod 255; 

// 2. Generate the color (Hue, Saturation: 220, Value/Brightness: 255)
// Keeping saturation and value high ensures you get bright, neon colors instead of dark mud.
var _combo_color = make_color_hsv(_hue, 220, 255);

// 3. Draw the text
draw_set_color(_combo_color);
draw_text(x, y, "Combo: " + string(global.combo_count));

// 4. Always reset to white so other graphics don't get tinted
draw_set_color(c_white);