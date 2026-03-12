// --- oPowerUpHealth : Collision with oPlayer ---

// 1. Pick a random percentage between 5% (0.05) and 20% (0.20)
var _heal_percent = random_range(0.05, 0.20);

// 2. Calculate the actual heal amount based on the player's max health
// Note: "other" refers to the player in a collision event!
var _heal_amount = round(other.max_hp * _heal_percent); 

// 3. Add the health to the player
other.hp += _heal_amount;

// 4. Cap the health so they don't go over their maximum!
if (other.hp > other.max_hp) 
{
    other.hp = other.max_hp;
}

// 5. (BONUS) Create green floating text to show exactly how much they healed!
var _text_pop = instance_create_depth(x, y - 20, depth - 100, oFloatingText);
with (_text_pop)
{
    my_text = "+" + string(_heal_amount) + " HP"; 
    my_color = c_lime; // Bright green for health
}

// 6. Destroy the health kit so it can't be picked up twice
instance_destroy();