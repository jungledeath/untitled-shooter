// --- pTarget : Destroy Event ---

// ONLY roll the dice if the 5-second cooldown has reached 0
if (global.powerup_cooldown <= 0)
{
    var _roll = irandom(99); 
    var _drop_chance = 15; // 10% chance to drop *something*

    if (_roll < _drop_chance) 
    {
        // 1. Choose WHICH power-up to drop (50/50 chance)
        // The choose() function randomly picks one of the items in its list
        var _loot = choose(oBomb, oPowerUpHealth, oPowerUpFreeze, oPowerUpSpeed);
        
        // 2. Drop the chosen item!
        instance_create_depth(x, y, depth, _loot);
        
        // 3. Start the 5-second cooldown
        global.powerup_cooldown = 300; 
    }
}