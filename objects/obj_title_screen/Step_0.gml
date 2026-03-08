anim_timer++;
logo_pulse = sin(anim_timer * 0.04) * 3;

btn_alpha = lerp(btn_alpha, 1.0, 0.04);
btn_y_off = lerp(btn_y_off, 0,   0.07);

// Falling food
var _W = display_get_gui_width();
var _H = display_get_gui_height();
for (var i = 0; i < array_length(floaties); i++) {
    var _f       = floaties[i];
    _f.y        += _f.vy;
    _f.rot      += _f.rot_s;
    _f.wobble   += _f.wobble_s;
    _f.x        += sin(_f.wobble) * 0.5;
    if (_f.y > _H + 40) {
        _f.y   = -40;
        _f.x   = random(_W);
        _f.spr = ing_sprs[irandom(array_length(ing_sprs) - 1)];
    }
}

// Mouse
var _mx  = device_mouse_x_to_gui(0);
var _my  = device_mouse_y_to_gui(0);
var _cx  = _W * 0.5;
var _by1 = _H * 0.55 + btn_y_off;
var _hy1 = _by1 + 62;

play_hover  = point_in_rectangle(_mx, _my, _cx - 130, _by1, _cx + 130, _by1 + 52);
howto_hover = point_in_rectangle(_mx, _my, _cx - 130, _hy1, _cx + 130, _hy1 + 52);

if (mouse_check_button_pressed(mb_left)) {
    if (play_hover)  room_goto(rm_level_select);
    if (howto_hover) instance_create_layer(0, 0, "Instances", obj_ui_howtoplay);
}