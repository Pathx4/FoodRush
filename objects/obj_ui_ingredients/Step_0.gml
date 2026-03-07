if (global.game_state != GAME_STATE.PLAYING) exit;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(buttons); i++) {
    var _b  = buttons[i];
    var _in = point_in_rectangle(_mx, _my,
                  _b.bx, _b.by,
                  _b.bx + btn_size, _b.by + btn_size);
    _b.hover = _in;
    _b.scale = lerp(_b.scale, _in ? 1.07 : 1.0, 0.2);
}

if (mouse_check_button_pressed(mb_left)) {
    for (var i = 0; i < array_length(buttons); i++) {
        var _b = buttons[i];
        if (point_in_rectangle(_mx, _my,
                _b.bx, _b.by,
                _b.bx + btn_size, _b.by + btn_size)) {
            array_push(global.tray, _b.ing_id);
            _b.scale = 0.88;
            play_sound(SND_CLICK);
            with (obj_ui_tray)   { event_user(0); }
            with (obj_ui_orders) { event_user(0); }
            break;
        }
    }
}