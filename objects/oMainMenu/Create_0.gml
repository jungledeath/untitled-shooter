// --- MENU SETUP ---
menu_options = ["START GAME", "SETTINGS", "CREDITS"];
menu_index = 0;      // 0 = Start, 1 = Settings, 2 = Credits
input_cooldown = 0;  // Prevents the stick from flying past options

// ==========================================
// 1. MENU SETUP (Moved to Top Left)
// ==========================================
menu_options = ["START GAME", "SETTINGS", "CREDITS"];
menu_index = 0;      
input_cooldown = 0;  

// New Top-Left Coordinates for your buttons
start_x = 100; // 100 pixels in from the left edge
start_y = 100; // 100 pixels down from the top edge
gap = 40;      // Closer together (used to be 50)

// ==========================================
// 2. HIGH SCORE SYSTEM (JSON)
// ==========================================
// We use a global array so the game room can easily add scores to it later!
global.high_scores = []; 
var _save_file = "highscores.json";

if (file_exists(_save_file))
{
    // If they have played before, open the file and read the JSON
    var _file = file_text_open_read(_save_file);
    var _json_string = file_text_read_string(_file);
    file_text_close(_file);
    
    // Convert the text file back into a GameMaker array
    global.high_scores = json_parse(_json_string);
}
else
{
    // If it's their first time playing, create 10 blank placeholder scores!
    for (var i = 0; i < 10; i++)
    {
        // Each entry is a "Struct" holding a Name and a Score
        array_push(global.high_scores, { name: "---", score: 0 });
    }
    
    // Convert this brand new array into text and save it to the hard drive
    var _json_string = json_stringify(global.high_scores);
    var _file = file_text_open_write(_save_file);
    file_text_write_string(_file, _json_string);
    file_text_close(_file);
}