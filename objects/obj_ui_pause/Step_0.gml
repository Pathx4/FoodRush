var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;
var _cy = _H * 0.5;
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _pw = 320;
var _ph = 220;

// Button bounds
resume_hover = point_in_rectangle(_mx, _my,
    _cx - _pw * 0.5 + 20, _cy - 10,
    _cx + _pw * 0.5 - 20, _cy + 40);
quit_hover = point_in_rectangle(_mx, _my,
    _cx - _pw * 0.5 + 20, _cy + 50,
    _cx + _pw * 0.5 - 20, _cy + 95);

// Resume
if (mouse_check_button_pressed(mb_left) && resume_hover) {
    global.game_state = GAME_STATE.PLAYING;
    instance_destroy();
}

// Quit
if (mouse_check_button_pressed(mb_left) && quit_hover) {
    global.game_state = GAME_STATE.PLAYING;
    room_goto(rm_level_select);
    instance_destroy();
}

// ESC หรือ P
if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P"))) {
    global.game_state = GAME_STATE.PLAYING;
    instance_destroy();
}