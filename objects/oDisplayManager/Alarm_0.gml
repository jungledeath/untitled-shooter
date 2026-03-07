// 1. Get the actual iOS screen dimensions (forced to landscape)
var _disp_w = max(display_get_width(), display_get_height());
var _disp_h = min(display_get_width(), display_get_height());

if (_disp_w <= 0) {
    _disp_w = 2532;
    _disp_h = 1170;
}

// 2. Lock the Application Surface perfectly to the phone screen
surface_resize(application_surface, _disp_w, _disp_h);

// 3. Create Nate's struct camera
my_camera = new game_camera_create(0, VIEW_DEFAULT_WIDTH, VIEW_DEFAULT_HEIGHT);

// 4. Feed the screen dimensions into the camera's math
my_camera.update_viewport(_disp_w, _disp_h);

// 4.5 Force the GUI layer to perfectly match the camera's corrected aspect ratio
display_set_gui_size(my_camera.width, my_camera.height);

// 5. Turn on views and go to the main menu
view_enabled = true;
room_goto(rMainMenu);