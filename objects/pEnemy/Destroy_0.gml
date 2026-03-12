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
if (global.combo_count >= 6)
{
    var _combo_pop = instance_create_depth(x, y - 20, depth - 100, oFloatingText);
    with (_combo_pop)
    {
        my_text = "COMBO x" + string(global.combo_count);
        my_color = c_orange; 
        my_scale = 0.75; 
    }
}