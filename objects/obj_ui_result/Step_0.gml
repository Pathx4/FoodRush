if (!visible) exit;

popup_scale = lerp(popup_scale, 1.0, 0.15);
bg_alpha    = lerp(bg_alpha, 0.75, 0.10);

star_timer--;
if (star_timer <= 0 && stars_shown < stars) {
    stars_shown++;
    star_timer = 20;
}
for (var i = 0; i < 3; i++) {
    star_scales[i] = lerp(star_scales[i], (i < stars_shown) ? 1.0 : 0.0, 0.2);
}

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;
var _cy = _H * 0.5;
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _pw = 360;
var _ph = 380;
var _px = _cx - _pw * 0.5;
var _py = _cy - _ph * 0.5;

retry_hover = point_in_rectangle(_mx, _my,
    _px + 16,            _py + _ph - 140,
    _px + _pw * 0.5 - 8, _py + _ph - 96);
next_hover  = can_next && point_in_rectangle(_mx, _my,
    _px + _pw * 0.5 + 8, _py + _ph - 140,
    _px + _pw - 16,      _py + _ph - 96);
menu_hover  = point_in_rectangle(_mx, _my,
    _px + 16,        _py + _ph - 86,
    _px + _pw - 16,  _py + _ph - 50);

if (mouse_check_button_pressed(mb_left)) {
    if (retry_hover) {
        visible = false;
        scr_start_level(global.session_level_id);
        return;
    }
    if (can_next && next_hover) {
        visible = false;
        scr_start_level(global.session_level_id + 1);
        return;
    }
    if (menu_hover) {
        visible = false;
        room_goto(rm_level_select);
    }
}