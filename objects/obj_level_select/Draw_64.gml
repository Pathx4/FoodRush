var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;

// BG
draw_set_color(COL_BG);
draw_rectangle(0, 0, _W, _H, false);

// Particles
for (var i = 0; i < array_length(particles); i++) {
    var _p = particles[i];
    draw_set_color(_p.col);
    draw_set_alpha(_p.alpha);
    draw_circle(_p.x, _p.y, _p.size, false);
}
draw_set_alpha(1);

// Header
draw_panel(0, 0, _W, 66, 0, COL_SURFACE, COL_BORDER, 1);

// Back button
var _bk_fill = back_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
var _bk_bord = back_hover ? COL_ORANGE : COL_BORDER;
draw_panel(16, 14, 110, 50, 10, _bk_fill, _bk_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(back_hover ? COL_TEXT : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(63, 32, "< Back");

// Title
draw_set_font(fnt_title);
draw_set_color(COL_ORANGE);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_cx, 14, "Select Level");

// Total stars
var _total_stars = 0;
for (var i = 0; i < LEVEL.COUNT; i++) _total_stars += scr_get_stars(i, global.best_scores[i]);
draw_set_font(fnt_small);
draw_set_color(COL_YELLOW);
draw_set_halign(fa_right);
draw_text(_W - 20, 22, string(_total_stars) + " / " + string(LEVEL.COUNT * 3) + " stars");

// ── Cards ─────────────────────────────────────────────
var _cols    = 3;
var _card_w  = 200;
var _card_h  = 200;
var _gap_x   = 28;
var _gap_y   = 24;
var _grid_w  = _cols * _card_w + (_cols - 1) * _gap_x;
var _start_x = _W * 0.5 - _grid_w * 0.5;
var _start_y = 90;

for (var i = 0; i < LEVEL.COUNT; i++) {
    var _lv   = global.level_data[i];
    var _col  = i mod _cols;
    var _row  = floor(i / _cols);
    var _sc   = card_scales[i];
    var _ccx  = _start_x + _col * (_card_w + _gap_x) + _card_w * 0.5;
    var _ccy  = _start_y + _row * (_card_h + _gap_y) + _card_h * 0.5 + card_y_off[i];

    var _hw  = _card_w * _sc * 0.5;
    var _hh  = _card_h * _sc * 0.5;
    var _cx1 = _ccx - _hw;
    var _cy1 = _ccy - _hh;
    var _cx2 = _ccx + _hw;
    var _cy2 = _ccy + _hh;

    var _unlocked = (i == 0 || global.best_scores[i - 1] > 0);
    var _stars    = scr_get_stars(i, global.best_scores[i]);
    var _hover    = card_hover[i];

    // Shadow
    draw_set_color(c_black);
    draw_set_alpha(0.2);
    draw_roundrect_ext(_cx1 + 4, _cy1 + 6, _cx2 + 4, _cy2 + 6, 16, 16, false);
    draw_set_alpha(1);

    // Card BG
    var _fill = _unlocked
        ? (_hover ? merge_color(COL_SURFACE, COL_ORANGE, 0.08) : COL_SURFACE)
        : make_color_rgb(18, 9, 0);
    var _bord = _hover ? COL_ORANGE : (_unlocked ? COL_BORDER : make_color_rgb(40,20,0));
    draw_panel(_cx1, _cy1, _cx2, _cy2, 16, _fill, _bord, 1);

    // ── Number badge (มุมซ้ายบน) ──────────────────────
    draw_panel(_cx1 + 8, _cy1 + 8, _cx1 + 32, _cy1 + 30,
               8, COL_ORANGE, COL_ORANGE, 1);
    draw_set_font(fnt_bold);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_cx1 + 20, _cy1 + 19, string(i + 1));

    if (!_unlocked) {
        // Locked overlay
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_roundrect_ext(_cx1, _cy1, _cx2, _cy2, 16, 16, false);
        draw_set_alpha(1);

        draw_set_font(fnt_bold_big);
        draw_set_color(COL_TEXT2);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_ccx, _ccy, "LOCKED");

    } else {
        // ── Layout แนวตั้ง 3 ส่วน ─────────────────────
        // ส่วน 1: รูป (บน)       _cy1+8  ถึง _cy1+110
        // ส่วน 2: ชื่อ (กลาง)    _cy1+112 ถึง _cy1+148
        // ส่วน 3: คะแนน+ดาว (ล่าง) _cy1+150 ถึง _cy2-8

        // ── รูปอาหาร (ครึ่งบน) ────────────────────────
        var _img_cx = _ccx;
        var _img_cy = _cy1 + 68;   // กึ่งกลางรูป

        var _show_spr = -1;
        if (variable_struct_exists(_lv, "icon_spr") && sprite_exists(_lv.icon_spr)) {
            _show_spr = _lv.icon_spr;
        } else {
            var _fb = fallback_sprs[min(i, array_length(fallback_sprs) - 1)];
            if (_fb >= 0 && sprite_exists(_fb)) _show_spr = _fb;
        }

        if (_show_spr >= 0) {
            var _sw = sprite_get_width(_show_spr);
            var _sh = sprite_get_height(_show_spr);
            var _max_size = 80.0;
            var _ssc = min(_max_size / _sw, _max_size / _sh) * _sc;
            draw_sprite_ext(_show_spr, 0,
                _img_cx - _sw * 0.5 * _ssc,
                _img_cy - _sh * 0.5 * _ssc,
                _ssc, _ssc, 0, c_white, 1);
        }

        // ── ชื่อ level (กลาง) ─────────────────────────
        draw_set_font(fnt_bold);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_text(_ccx, _cy1 + 118, _lv.name);

        // ── Best score ────────────────────────────────
        if (global.best_scores[i] > 0) {
            draw_set_font(fnt_tiny);
            draw_set_color(COL_TEXT2);
            draw_text(_ccx, _cy1 + 150, "Best: " + string(global.best_scores[i]));
        }

        // ── Stars (ล่างสุด) ───────────────────────────
        var _star_gap = 28;
        var _star_sx  = _ccx - _star_gap - 15;
        var _star_y   = _cy2 - 28;

        for (var s = 0; s < 3; s++) {
            var _lit = (s < _stars);
            draw_set_alpha(_lit ? 1.0 : 0.2);
            if (_lit && sprite_exists(spr_star_on)) {
                draw_sprite_ext(spr_star_on, 0,
                    _star_sx + s * _star_gap, _star_y,
                    0.65, 0.65, 0, c_white, 1);
            } else if (!_lit && sprite_exists(spr_star_off)) {
                draw_sprite_ext(spr_star_off, 0,
                    _star_sx + s * _star_gap, _star_y,
                    0.65, 0.65, 0, c_white, 1);
            } else {
                draw_set_color(_lit ? COL_YELLOW : COL_SURFACE2);
                draw_circle(_star_sx + s * _star_gap, _star_y, 9, false);
            }
        }
        draw_set_alpha(1);

        // Hover shine
        if (_hover) {
            draw_set_color(c_white);
            draw_set_alpha(0.04);
            draw_roundrect_ext(_cx1, _cy1, _cx2, _cy2, 16, 16, false);
            draw_set_alpha(1);
        }
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
