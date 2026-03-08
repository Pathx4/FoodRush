anim_timer++;

// Particles
var _W = display_get_gui_width();
var _H = display_get_gui_height();
for (var i = 0; i < array_length(particles); i++) {
    var _p = particles[i];
    _p.y += _p.vy;
    if (_p.y < -10) {
        _p.y = _H + 10;
        _p.x = random(_W);
    }
}

// Layout
var _cols    = 3;
var _rows    = ceil(LEVEL.COUNT / _cols);
var _card_w  = 200;
var _card_h  = 180;
var _gap_x   = 28;
var _gap_y   = 28;
var _grid_w  = _cols * _card_w + (_cols - 1) * _gap_x;
var _grid_h  = _rows * _card_h + (_rows - 1) * _gap_y;
var _start_x = _W * 0.5 - _grid_w * 0.5;
var _start_y = 110;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

back_hover = point_in_rectangle(_mx, _my, 16, 14, 110, 50);

for (var i = 0; i < LEVEL.COUNT; i++) {
    var _col = i mod _cols;
    var _row = floor(i / _cols);
    var _cx  = _start_x + _col * (_card_w + _gap_x) + _card_w * 0.5;
    var _cy  = _start_y + _row * (_card_h + _gap_y) + card_y_off[i];

    // Animate in (stagger)
    var _delay = i * 4;
    if (anim_timer > _delay) {
        card_scales[i] = lerp(card_scales[i], 1.0, 0.12);
        card_y_off[i]  = lerp(card_y_off[i],  0.0, 0.10);
    }

    var _unlocked = (i == 0 || global.best_scores[i - 1] > 0);
    var _in = _unlocked && point_in_rectangle(_mx, _my,
        _cx - _card_w * 0.5, _cy - _card_h * 0.5,
        _cx + _card_w * 0.5, _cy + _card_h * 0.5);

    card_hover[i] = _in;
    card_scales[i] = lerp(card_scales[i], _in ? 1.06 : 1.0, 0.15);

    if (mouse_check_button_pressed(mb_left) && _in) {
        scr_start_level(i);
    }
}

if (mouse_check_button_pressed(mb_left) && back_hover) {
    room_goto(rm_title);
}
