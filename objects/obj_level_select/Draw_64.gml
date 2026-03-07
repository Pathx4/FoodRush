var _W = display_get_gui_width();
var _H = display_get_gui_height();

// Background
draw_set_color(COL_BG);
draw_rectangle(0, 0, _W, _H, false);

// Header
draw_set_font(fnt_title);
draw_set_color(COL_ORANGE);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_W * 0.5, 20, "Choose a Level");

draw_set_font(fnt_small);
draw_set_color(COL_TEXT2);
draw_text(_W * 0.5, 68, "Select your restaurant challenge");

// Loop วาด card ทั้งหมด
for (var i = 0; i < LEVEL.COUNT; i++) {
    var _lv    = global.level_data[i];
    var _col   = i mod card_cols;
    var _row   = floor(i / card_cols);
    var _bx    = grid_x + _col * (card_w + card_gap_x);
    var _by    = grid_y + _row * (card_h + card_gap_y);
    var _sc    = card_scales[i];
    var _lock  = !global.unlocked[i];
    var _best  = global.best_scores[i];
    var _stars = scr_get_stars(i, _best);

    // Center of card
    var _ccx = _bx + card_w * 0.5;
    var _ccy = _by + card_h * 0.5;

    // Card background
    var _fill = _lock ? COL_SURFACE : (hover_card == i ? COL_SURFACE2 : COL_SURFACE);
    var _bord = _lock ? COL_BORDER  : (hover_card == i ? COL_ORANGE : COL_BORDER);
    var _hw   = card_w * _sc * 0.5;
    var _hh   = card_h * _sc * 0.5;
    draw_panel(_ccx - _hw, _ccy - _hh, _ccx + _hw, _ccy + _hh, 20, _fill, _bord, _lock ? 0.5 : 1.0);

    // Level icon กึ่งกลางบน
    if (sprite_exists(_lv.icon)) {
        draw_sprite_ext(_lv.icon, 0,
            _bx + 85,
            _by + 30,
            _sc, _sc, 0, c_white, _lock ? 0.25 : 1.0);
    }

    // Level name กึ่งกลาง
    draw_set_font(fnt_bold_big);
    draw_set_color(_lock ? COL_TEXT2 : COL_TEXT);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_ccx, _by + 112, _lv.name);

    // Stars กึ่งกลางล่าง
    var _star_start_x = _bx - (3 * 34 * 0.5) + 120;
    for (var s = 0; s < 3; s++) {
        var _star_spr = (s < _stars) ? spr_star_on : spr_star_off;
        draw_sprite_ext(_star_spr, 0,
            _star_start_x + s * 34,
            _by + card_h - 42,
            0.7, 0.7, 0, c_white, _lock ? 0.25 : 1.0);
    }

    // Best score
    if (!_lock && _best > 0) {
        draw_set_font(fnt_tiny);
        draw_set_color(COL_TEXT2);
        draw_set_halign(fa_center);
        draw_text(_ccx, _by + card_h - 18, "Best: " + string(_best));
    }

    // Lock overlay
    if (_lock) {
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        draw_roundrect_ext(_bx, _by, _bx + card_w, _by + card_h, 20, 20, false);
        draw_set_alpha(1);

        if (sprite_exists(spr_lock)) {
            draw_sprite_ext(spr_lock, 0, _ccx - 25, _ccy - 45, 1, 1, 0, c_white, 1);
        } else {
            draw_panel(_ccx - 52, _ccy - 18, _ccx + 52, _ccy + 18, 10,
                       make_color_rgb(30,20,10), COL_BORDER, 1);
            draw_set_font(fnt_bold);
            draw_set_color(COL_TEXT2);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text(_ccx, _ccy, "LOCKED");
            draw_set_valign(fa_top);
        }
    }
}

// Back button
var _mx2        = device_mouse_x_to_gui(0);
var _my2        = device_mouse_y_to_gui(0);
var _back_hover = point_in_rectangle(_mx2, _my2, 20, _H - 60, 140, _H - 20);
var _back_fill  = _back_hover ? COL_SURFACE2 : make_color_rgb(35, 18, 0);
var _back_bord  = _back_hover ? COL_ORANGE : COL_BORDER;

draw_panel(20, _H - 60, 140, _H - 20, 14, _back_fill, _back_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(_back_hover ? COL_TEXT : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(80, _H - 40, "< Back");

draw_set_halign(fa_left);
draw_set_valign(fa_top);