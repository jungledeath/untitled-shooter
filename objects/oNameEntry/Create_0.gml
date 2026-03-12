// ==========================================
// 1. ARCADE SCROLLER SETUP
// ==========================================
// The characters they can choose from
alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","-","."," "];

// The 3 letters of their name (This holds the INDEX of the alphabet array. 0 = 'A')
name_array = [0, 0, 0]; 

// Which of the 3 slots are we currently editing? (0, 1, or 2)
current_slot = 0;       

// Stop the joystick from flying too fast
input_cooldown = 0;