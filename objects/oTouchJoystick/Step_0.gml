// oTouchJoystick Step Event

// 1. Check if the player is using a gamepad
var _using_gamepad = InputPlayerUsingGamepad();

// 2. Simply toggle this specific object's visibility
visible = !_using_gamepad;