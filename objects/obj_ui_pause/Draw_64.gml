
var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;
var _cy = _H * 0.5;
var _pw = 320;
var _ph = 220;

// Dim overlay
draw_set_color(c_black);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

// Popup panel
draw_panel(
    _cx - _pw * 0.5, _cy - _ph * 0.5,
    _cx + _pw * 0.5, _cy + _ph * 0.5,
    20, COL_SURFACE, COL_BORDER, 1);

// Title
draw_set_font(fnt_title);
draw_set_color(COL_TEXT);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_cx, _cy - _ph * 0.5 + 18, "Paused");

// Subtitle
draw_set_font(fnt_small);
draw_set_color(COL_TEXT2);
draw_text(_cx, _cy - _ph * 0.5 + 60, "Your orders are waiting!");

// Resume button
var _rb_fill = resume_hover ? make_color_rgb(56, 200, 60) : COL_GREEN;
draw_panel(
    _cx - _pw * 0.5 + 20, _cy - 10,
    _cx + _pw * 0.5 - 20, _cy + 40,
    12, _rb_fill, _rb_fill, 1);
draw_set_font(fnt_bold_big);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _cy + 15, "Resume");

// Quit button
var _qb_fill = quit_hover ? make_color_rgb(180, 40, 40) : COL_SURFACE2;
var _qb_bord = quit_hover ? COL_RED : COL_BORDER;
draw_panel(
    _cx - _pw * 0.5 + 20, _cy + 50,
    _cx + _pw * 0.5 - 20, _cy + 95,
    12, _qb_fill, _qb_bord, 1);
draw_set_font(fnt_bold);
draw_set_color(quit_hover ? c_white : COL_TEXT2);
draw_set_valign(fa_middle);
draw_text(_cx, _cy + 72, "Quit to Menu");

draw_set_halign(fa_left);
draw_set_valign(fa_top);