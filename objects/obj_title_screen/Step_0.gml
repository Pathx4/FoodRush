
	logo_y    = lerp(logo_y,    logo_target, 0.08);
    btn_alpha = lerp(btn_alpha, 1.0,         0.04);
    btn_y_off = lerp(btn_y_off, 0,           0.07);

    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    play_hover  = point_in_rectangle(_mx, _my, _cx - 130, _H * 0.55 + btn_y_off, _cx + 130, _H * 0.55 + btn_y_off + 52);
    howto_hover = point_in_rectangle(_mx, _my, _cx - 130, _H * 0.55 + btn_y_off + 62, _cx + 130, _H * 0.55 + btn_y_off + 114);

    // Animate floaties
    for (var i = 0; i < array_length(floaties); i++) {
        var _f = floaties[i];
        _f.y   += _f.vy;
        _f.rot += _f.vrot;
        if (_f.y < -60) {
            _f.y = _H + 30;
            _f.x = random(_W);
        }
    }
	// Step Event ของ obj_title_screen
// เพิ่มต่อจาก code เดิมที่มีอยู่แล้ว

if (mouse_check_button_pressed(mb_left)) {
    var _W   = display_get_gui_width();
    var _H   = display_get_gui_height();
    var _cx  = _W * 0.5;
    var _mx  = device_mouse_x_to_gui(0);
    var _my  = device_mouse_y_to_gui(0);
    var _by1 = _H * 0.55 + btn_y_off;
    var _hy1 = _by1 + 62;

    // Play Game
    if (point_in_rectangle(_mx, _my, _cx - 130, _by1, _cx + 130, _by1 + 52)) {
        room_goto(rm_level_select);
    }

    // How to Play
    if (point_in_rectangle(_mx, _my, _cx - 130, _hy1, _cx + 130, _hy1 + 52)) {
        show_message("How to Play!");
    }
}