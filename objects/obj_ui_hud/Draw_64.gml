score_display = global.session_score;
var _W = display_get_gui_width();

// HUD background
draw_panel(0, 0, _W, hud_h, 0, COL_SURFACE, COL_BORDER, 1);

// Level name
draw_set_font(fnt_bold_big);
draw_set_color(COL_ORANGE);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(14, hud_h * 0.5, global.level_data[global.session_level_id].name);

// Score chip
draw_panel(190, 10, 320, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(202, 18, "SCORE");
draw_set_font(fnt_bold_big);
draw_set_color(COL_YELLOW);
draw_text(202, 38, string(floor(score_display)));

// Earned chip
draw_panel(328, 10, 458, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(340, 18, "EARNED");
draw_set_font(fnt_bold_big);
draw_set_color(COL_GREEN);
draw_text(340, 38, "$" + string(global.session_money));

// Lives chip
draw_panel(466, 10, 566, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(478, 18, "LIVES");
var _heart_col  = (hearts_flash > 0) ? merge_color(COL_RED, c_white, hearts_flash) : COL_RED;
var _heart_size = 18;
var _heart_gap  = 4;
var _heart_sx   = 478;
var _heart_y    = 40;
if (global.session_lives <= 0) {
    draw_set_font(fnt_bold_big);
    draw_set_color(COL_TEXT2);
    draw_text(_heart_sx, _heart_y, "---");
} else {
    for (var h = 0; h < max(0, global.session_lives); h++) {
        if (sprite_exists(spr_heart)) {
            draw_sprite_ext(spr_heart, 0,
                _heart_sx + h * (_heart_size + _heart_gap),
                _heart_y,
                0.5, 0.5, 0, _heart_col, 1);
        } else {
            draw_set_color(_heart_col);
            draw_roundrect_ext(
                _heart_sx + h * (_heart_size + _heart_gap),
                _heart_y,
                _heart_sx + h * (_heart_size + _heart_gap) + _heart_size,
                _heart_y + _heart_size,
                4, 4, false);
        }
    }
}

// Combo chip
draw_panel(574, 10, 664, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(586, 18, "COMBO");
var _combo_col = (global.session_combo >= 3) ? COL_ORANGE : COL_TEXT;
draw_set_font(fnt_bold_big);
draw_set_color(_combo_col);
draw_text(586, 38, "x" + string(max(1, global.session_combo)));

// Timer bar
var _bar_x = 672 + timer_shake;
var _bar_w  = _W - _bar_x - 120;
var _pct    = global.time_left / global.level_data[global.session_level_id].duration;
var _t_col;
if (_pct > 0.5) {
    _t_col = COL_GREEN;
} else if (_pct > 0.2) {
    _t_col = COL_ORANGE;
} else {
    _t_col = COL_RED;
}
draw_progress_bar(_bar_x, 28, _bar_w, 14, _pct, COL_SURFACE2, _t_col, 7);
draw_set_font(fnt_small);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_center);
draw_text(_bar_x + _bar_w * 0.5, 50, scr_format_time(ceil(global.time_left)));

// Pause button
var _pb_fill = pause_hover ? COL_SURFACE2 : make_color_rgb(35, 18, 0);
var _pb_bord = pause_hover ? COL_ORANGE : COL_BORDER;
draw_panel(_W - 110, 14, _W - 10, hud_h - 14, 12, _pb_fill, _pb_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(pause_hover ? COL_TEXT : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_W - 60, hud_h * 0.5, "Pause");

// ── Admin status indicator ────────────────────────────
if (variable_global_exists("admin_freeze") || variable_global_exists("admin_speed")) {
    var _admin_active = (variable_global_exists("admin_freeze") && global.admin_freeze)
                     || (variable_global_exists("admin_speed") && global.admin_speed != 1.0)
                     || (variable_global_exists("admin_autofill") && global.admin_autofill);
    if (_admin_active) {
        var _badge_x = _W - 230;
        draw_panel(_badge_x, 16, _badge_x + 108, hud_h - 16, 8,
                   make_color_rgb(20, 10, 40), make_color_rgb(100, 50, 180), 1);
        draw_set_font(fnt_tiny);
        draw_set_color(make_color_rgb(180, 130, 255));
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        var _badge_txt = "";
        if (variable_global_exists("admin_freeze") && global.admin_freeze) {
            _badge_txt = "ADMIN: FROZEN";
        } else if (variable_global_exists("admin_speed") && global.admin_speed != 1.0) {
            _badge_txt = "ADMIN: " + string(global.admin_speed) + "x";
        } else {
            _badge_txt = "ADMIN: ON";
        }
        draw_text(_badge_x + 54, hud_h * 0.5, _badge_txt);
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);