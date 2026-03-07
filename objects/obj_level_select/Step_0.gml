var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
hover_card = -1;

for (var i = 0; i < LEVEL.COUNT; i++) {
    var _col   = i mod card_cols;
    var _row   = floor(i / card_cols);
    var _bx    = grid_x + _col * (card_w + card_gap_x);
    var _by    = grid_y + _row * (card_h + card_gap_y);
    var _hover = global.unlocked[i] && point_in_rectangle(_mx, _my, _bx, _by, _bx + card_w, _by + card_h);
    if (_hover) hover_card = i;
    var _ts = _hover ? 1.02 : 0.97;
    card_scales[i] = lerp(card_scales[i], _ts, 0.2);
}

// Mouse click
if (mouse_check_button_pressed(mb_left)) {
    var _H = display_get_gui_height();

    // Back button
    if (point_in_rectangle(_mx, _my, 20, _H - 60, 140, _H - 20)) {
        room_goto(rm_title);
    }

    // Level cards
    for (var i = 0; i < LEVEL.COUNT; i++) {
        var _col = i mod card_cols;
        var _row = floor(i / card_cols);
        var _bx  = grid_x + _col * (card_w + card_gap_x);
        var _by  = grid_y + _row * (card_h + card_gap_y);
        if (global.unlocked[i]) {
            if (point_in_rectangle(_mx, _my, _bx, _by, _bx + card_w, _by + card_h)) {
                scr_start_level(i);
            }
        }
    }
}