// Dynamic Bottom-Left Anchor
x = 100; 
y = display_get_gui_height() - 100;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Lock the math directly to your base sprite's actual width!
radius = sprite_get_width(sJoyBase) / 2; 

// Place it comfortably in the corner based on its own size
var _margin = radius * 1.5;
base_x = _margin; 
base_y = _gui_h - _margin;

// 3. Create the joystick and tighten the deadzone
v_joy = InputVirtualCreate()
    .Circle(base_x, base_y, radius)
    .Thumbstick(undefined, INPUT_VERB.LEFT, INPUT_VERB.RIGHT, INPUT_VERB.UP, INPUT_VERB.DOWN)
    .Threshold(0.1, 1.0) // <--- THE MAGIC FIX: Makes it responsive instantly
    .Follow(false)
    .ReleaseBehavior(INPUT_VIRTUAL_RELEASE.RESET_POSITION);
	
// --- BOOST BUTTON (BOTTOM RIGHT) ---
var _margin = 40; // Distance from the corner
var _boost_x = _gui_w - _margin;
var _boost_y = _gui_h - _margin;

// Give it a forgiving 30-pixel radius (60px total width) 
// so your thumb doesn't have to be pixel-perfect!
var _boost_radius = 30; 

v_boost = InputVirtualCreate()
    .Circle(_boost_x, _boost_y, _boost_radius)
    .Button(INPUT_VERB.BOOST);