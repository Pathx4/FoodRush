popup_scale = lerp(popup_scale, 1.0, 0.18);
bg_alpha    = lerp(bg_alpha,    0.7, 0.12);

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;
var _cy = _H * 0.5;
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// คำนวณขนาด popup จริง
var _pw = 320 * popup_scale;
var _ph = 220 * popup_scale;

resume_hover = point_in_rectangle(_mx, _my, _cx - _pw*0.5 + 20, _cy + 10, _cx + _pw*0.5 - 20, _cy + 55);
quit_hover   = point_in_rectangle(_mx, _my, _cx - _pw*0.5 + 20, _cy + 65, _cx + _pw*0.5 - 20, _cy + 110);

// คลิก Resume
if (mouse_check_button_pressed(mb_left) && resume_hover) {
    global.game_state = GAME_STATE.PLAYING;
    instance_destroy();
}

// คลิก Quit
if (mouse_check_button_pressed(mb_left) && quit_hover) {
    global.game_state = GAME_STATE.PLAYING;
    room_goto(rm_title);
    instance_destroy();
}

// ESC กด resume
if (keyboard_check_pressed(ord("P")) || keyboard_check_pressed(vk_escape)) {
    global.game_state = GAME_STATE.PLAYING;
    instance_destroy();
}