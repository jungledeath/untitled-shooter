// 1. A short delay (1 second at 60fps) so the player doesn't 
// accidentally skip the screen while mashing the shoot button!
timer = 60; 

// 2. Did they make the Top 10?
is_high_score = false; 

// We check against index 9, which is the 10th slot on the leaderboard
if (variable_global_exists("high_scores"))
{
    if (global.player_score > global.high_scores[9].score)
    {
        is_high_score = true;
    }
}