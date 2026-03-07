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
draw_text(202, 18, "SCORE");
draw_set_font(fnt_bold_big);
draw_set_color(COL_YELLOW);
draw_text(202, 40, string(floor(score_display)));

// Earned chip
draw_panel(328, 10, 458, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(340, 18, "EARNED");
draw_set_font(fnt_bold_big);
draw_set_color(COL_GREEN);
draw_text(340, 40, "$" + string(global.session_money));

// Lives chip
draw_panel(466, 10, 566, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(478, 18, "LIVES");
var _heart_col = (hearts_flash > 0) ? merge_color(COL_RED, c_white, hearts_flash) : COL_RED;
draw_set_font(fnt_bold_big);
draw_set_color(_heart_col);
var _hearts_str = "";
repeat (max(0, global.session_lives)) { _hearts_str += "♥ "; }
if (global.session_lives <= 0) _hearts_str = "---";
draw_text(478, 40, _hearts_str);

// Combo chip
draw_panel(574, 10, 664, hud_h - 10, 16, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(586, 18, "COMBO");
var _combo_col = (global.session_combo >= 3) ? COL_ORANGE : COL_TEXT;
draw_set_font(fnt_bold_big);
draw_set_color(_combo_col);
draw_text(586, 40, "x" + string(max(1, global.session_combo)));

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
draw_progress_bar(_bar_x, 26, _bar_w, 14, _pct, COL_SURFACE2, _t_col, 7);
draw_set_font(fnt_small);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_center);
draw_text(_bar_x + _bar_w * 0.5, 48, scr_format_time(ceil(global.time_left)));

// Pause button
var _pb_fill = pause_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
var _pb_bord = pause_hover ? COL_ORANGE : COL_BORDER;
draw_panel(_W - 110, 14, _W - 10, hud_h - 14, 12, _pb_fill, _pb_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(pause_hover ? COL_TEXT : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_W - 60, hud_h * 0.5, "Pause");

draw_set_halign(fa_left);
draw_set_valign(fa_top);