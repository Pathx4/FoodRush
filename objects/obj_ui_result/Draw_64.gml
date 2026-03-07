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

// Popup panel
var _pw = 440 * popup_scale;
var _ph = 340 * popup_scale;
draw_panel(_cx - _pw * 0.5, _cy - _ph * 0.5,
           _cx + _pw * 0.5, _cy + _ph * 0.5,
           24, COL_SURFACE, COL_BORDER, 1);

// Result sprite
if (sprite_exists(result_spr)) {
    draw_sprite_ext(result_spr, 0,
        _cx, _cy - 130,
        popup_scale, popup_scale,
        0, c_white, 1);
} else {
    draw_panel(_cx - 32, _cy - 158, _cx + 32, _cy - 98,
               12, result_col, result_col, 0.8);
}

// Title
draw_set_font(fnt_title);
draw_set_color(result_col);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_cx, _cy - 90, result_title);

// Stars
var _star_gap = 56;
for (var i = 0; i < 3; i++) {
    var _sx  = _cx - _star_gap + i * _star_gap;
    var _ss  = star_scales[i];
    draw_set_alpha((i < stars) ? 1.0 : 0.2);
    var _spr = (i < stars_shown) ? spr_star_off : spr_star_on;
    if (sprite_exists(_spr)) {
        draw_sprite_ext(_spr, 0, _sx, _cy - 45,
                        _ss * 1.4, _ss * 1.4, 0, c_white, 1);
    }
}
draw_set_alpha(1);

// Stats
draw_panel(_cx - 155, _cy + 10, _cx - 55,  _cy + 70, 10, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_center);
draw_text(_cx - 105, _cy + 18, "SCORE");
draw_set_font(fnt_bold_big);
draw_set_color(COL_YELLOW);
draw_text(_cx - 105, _cy + 36, string(global.session_score));

draw_panel(_cx - 50,  _cy + 10, _cx + 50,  _cy + 70, 10, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(_cx, _cy + 18, "EARNED");
draw_set_font(fnt_bold_big);
draw_set_color(COL_GREEN);
draw_text(_cx, _cy + 36, "$" + string(global.session_money));

draw_panel(_cx + 55,  _cy + 10, _cx + 155, _cy + 70, 10, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(_cx + 105, _cy + 18, "LIVES");
draw_set_font(fnt_bold_big);
draw_set_color(COL_RED);
draw_text(_cx + 105, _cy + 36, string(max(0, global.session_lives)));

// ── Retry button ──────────────────────────────────────
var _r_fill = retry_hover ? make_color_rgb(220,80,0) : COL_ORANGE;
draw_panel(_cx - 145, _cy + 105, _cx - 10, _cy + 150, 14, _r_fill, _r_fill, 1);
draw_set_font(fnt_bold_big);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx - 77, _cy + 127, "Retry");

// ── Next Level button ─────────────────────────────────
if (can_next) {
    var _n_fill = next_hover ? make_color_rgb(40,180,45) : COL_GREEN;
    draw_panel(_cx + 10, _cy + 105, _cx + 145, _cy + 150, 14, _n_fill, _n_fill, 1);
    draw_set_font(fnt_bold_big);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_cx + 77, _cy + 127, "Next Level");  // ← ข้อความชัดเจน
}

// ── Level Select button ───────────────────────────────
var _m_fill = menu_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
var _m_bord = menu_hover ? COL_ORANGE : COL_BORDER;
draw_panel(_cx - 135, _cy + 160, _cx + 135, _cy + 198, 14, _m_fill, _m_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(menu_hover ? COL_TEXT : COL_TEXT2);
draw_set_valign(fa_middle);
draw_text(_cx, _cy + 179, "Level Select");

draw_set_halign(fa_left);
draw_set_valign(fa_top);