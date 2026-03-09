if (global.game_state != GAME_STATE.PLAYING) exit;

if (mouse_check_button_pressed(mb_left)) {
    var _mx     = device_mouse_x_to_gui(0);
    var _my     = device_mouse_y_to_gui(0);
    var _card_y = panel_y + 46;
    var _drawn  = 0;

    for (var i = 0; i < array_length(global.orders); i++) {
        var _o = global.orders[i];
        if (_o.state != ORDER_STATE.WAITING) continue;

        var _cx1 = panel_x + 6;
        var _cy1 = _card_y + _drawn * (card_h + card_gap);
        var _cx2 = panel_x + panel_w - 6;
        var _cy2 = _cy1 + card_h;

        if (_cy1 + card_h > panel_y + panel_h) break;
        _drawn++;

        if (point_in_rectangle(_mx, _my, _cx1, _cy1, _cx2, _cy2)) {
            // auto-fill เฉพาะตอน admin_autofill เปิดอยู่
            if (variable_global_exists("admin_autofill") && global.admin_autofill) {
                scr_autofill_tray(i);
            }
            break;
        }
    }
}
