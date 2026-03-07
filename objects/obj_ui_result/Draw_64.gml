if (!visible) exit;

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;
var _cy = _H * 0.5;

// Dim BG
draw_set_color(c_black);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

if (popup_scale < 0.05) exit;

// ── Popup panel ───────────────────────────────────────
var _pw = 380;
var _ph = 360;
var _px = _cx - _pw * 0.5;
var _py = _cy - _ph * 0.5;

draw_panel(_px, _py, _px + _pw, _py + _ph, 24, COL_SURFACE, COL_BORDER, 1);

// ── Row 1: Icon (ซ้าย) + Title (ขวา) ─────────────────
var _row1_y = _py + 20;

// Result sprite ซ้ายบน
if (sprite_exists(result_spr)) {
    draw_sprite_ext(result_spr, 0,
        _px + 44, _row1_y + 28,
        0.9 * popup_scale, 0.9 * popup_scale,
        0, c_white, 1);
} else {
    draw_set_color(result_col);
    draw_roundrect_ext(_px + 16, _row1_y, _px + 72, _row1_y + 56, 8, 8, false);
}

// Title ขวาของ icon
draw_set_font(fnt_title);
draw_set_color(result_col);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_px + 90, _row1_y + 28, result_title);

// ── Row 2: Stars ──────────────────────────────────────
var _row2_y  = _py + 96;
var _star_gap = 62;
var _star_sx  = _cx - _star_gap;

for (var i = 0; i < 3; i++) {
    var _ss  = star_scales[i];
    var _sx  = _star_sx + i * _star_gap;
    draw_set_alpha((i < stars) ? 1.0 : 0.2);
    if (sprite_exists(spr_star_on)) {
        var _spr = (i < stars_shown) ? spr_star_on : spr_star_off;
        draw_sprite_ext(_spr, 0, _sx, _row2_y,
                        _ss * 1.5, _ss * 1.5, 0, c_white, 1);
    }
}
draw_set_alpha(1);

// ── Row 3: Stat boxes ─────────────────────────────────
var _row3_y = _py + 160;
var _sw3    = (_pw - 48) / 3;

// SCORE
draw_panel(_px + 16,              _row3_y,
           _px + 16 + _sw3,       _row3_y + 70,
           10, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_px + 16 + _sw3 * 0.5, _row3_y + 10, "SCORE");
draw_set_font(fnt_bold_big);
draw_set_color(COL_YELLOW);
draw_text(_px + 16 + _sw3 * 0.5, _row3_y + 32, string(global.session_score));

// EARNED
draw_panel(_px + 24 + _sw3,       _row3_y,
           _px + 24 + _sw3 * 2,   _row3_y + 70,
           10, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(_px + 24 + _sw3 * 1.5, _row3_y + 10, "EARNED");
draw_set_font(fnt_bold_big);
draw_set_color(COL_GREEN);
draw_text(_px + 24 + _sw3 * 1.5, _row3_y + 32, "$" + string(global.session_money));

// LIVES
draw_panel(_px + 32 + _sw3 * 2,   _row3_y,
           _px + _pw - 16,         _row3_y + 70,
           10, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(_px + 32 + _sw3 * 2.5, _row3_y + 10, "LIVES");
draw_set_font(fnt_bold_big);
draw_set_color(COL_RED);
draw_text(_px + 32 + _sw3 * 2.5, _row3_y + 32, string(max(0, global.session_lives)));

// ── Row 4: Retry + Next Level ─────────────────────────
var _row4_y = _py + _ph - 130;
var _btn_h  = 40;
var _half_w = (_pw - 48) * 0.5;

// Retry
var _r_fill = retry_hover ? make_color_rgb(220,80,0) : COL_ORANGE;
draw_panel(_px + 16,              _row4_y,
           _px + 16 + _half_w,    _row4_y + _btn_h,
           12, _r_fill, _r_fill, 1);
draw_set_font(fnt_bold_big);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_px + 16 + _half_w * 0.5, _row4_y + _btn_h * 0.5, "Retry");

// Next Level
if (can_next) {
    var _n_fill = next_hover ? make_color_rgb(40,180,45) : COL_GREEN;
    draw_panel(_px + 24 + _half_w,       _row4_y,
               _px + 24 + _half_w * 2,   _row4_y + _btn_h,
               12, _n_fill, _n_fill, 1);
    draw_set_font(fnt_bold_big);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_px + 24 + _half_w * 1.5, _row4_y + _btn_h * 0.5, "Next Level");
}

// ── Row 5: Level Select ───────────────────────────────
var _row5_y  = _py + _ph - 80;
var _m_fill  = menu_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
var _m_bord  = menu_hover ? COL_ORANGE : COL_BORDER;
draw_panel(_px + 16,      _row5_y,
           _px + _pw - 16, _row5_y + 36,
           12, _m_fill, _m_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(menu_hover ? COL_TEXT : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _row5_y + 18, "Level Select");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
