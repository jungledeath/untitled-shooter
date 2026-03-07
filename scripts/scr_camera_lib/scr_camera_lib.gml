// scr_camera_lib
#macro VIEW_DEFAULT_WIDTH  717
#macro VIEW_DEFAULT_HEIGHT 330
#macro VIEW_DEFAULT_FOLLOW_OBJECT oPlayer

function game_camera_create(_viewport_index, _view_width, _view_height) constructor {
    
    // Viewport & Camera Setup
    viewport_index   = _viewport_index;
    id               = camera_create();
    x                = 0;
    y                = 0;
    width            = 0;
    height           = 0;
    view_width       = _view_width;  
    view_height      = _view_height; 
    
    // Follow Setup
    follow_object    = VIEW_DEFAULT_FOLLOW_OBJECT; 
    follow           = noone;
    follow_x         = 0;
    follow_y         = 0;
    follow_speed     = 0.1; // Smooth camera speed (lerp)
    
    static update = function() {
        if (instance_exists(follow)) {
            follow_x += (follow.x - follow_x) * follow_speed;
            follow_y += (follow.y - follow_y) * follow_speed;
        } else {
            follow = instance_nearest(x, y, follow_object);
        }
        
        // Clamp to room bounds
        x = clamp(follow_x - width * 0.5, 0, room_width - width);
        y = clamp(follow_y - height * 0.5, 0, room_height - height);    
        
        camera_set_view_size(id, width, height);
        camera_set_view_pos(id, x, y);
    }
    
    static update_viewport = function(_window_width, _window_height) {
        view_set_visible(viewport_index, true);
        view_set_camera(viewport_index, id);
        view_set_wport(viewport_index, _window_width);
        view_set_hport(viewport_index, _window_height);
        
        // Nate's Magic Aspect Ratio Math (No Black Bars!)
        var _aspect_view = _window_height / _window_width;
        var _aspect_cam  = view_height / view_width;
        
        if (_aspect_view > _aspect_cam) {
            var _excess = view_height * (_aspect_view / _aspect_cam - 1);  
            height = view_height + _excess;
            width = view_width;
        } else {
            var _excess = view_width * (_aspect_cam / _aspect_view - 1);  
            width = view_width + _excess;
            height = view_height;
        }
    }
    
    static room_start = function() {
        follow = instance_nearest(x, y, follow_object);
        if (instance_exists(follow)) {
            follow_x = follow.x;
            follow_y = follow.y;
        }
        update();
    }
}