// Make sure the camera has actually been created first
if (my_camera != -1) {
    
    // 1. Turn on the viewport system for this specific room
    view_enabled = true;
    view_set_visible(0, true);
    
    // 2. THE FIX: Force the room to look through our custom camera, not its default one!
    view_set_camera(0, my_camera.id); 
    
    // 3. Snap the camera's coordinates to the player instantly
    my_camera.room_start();
}