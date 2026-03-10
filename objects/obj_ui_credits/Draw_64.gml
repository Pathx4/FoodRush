var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = panel_x + panel_w * 0.5;

// Dim BG
draw_set_color(c_black);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

// Panel
draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h,
           20, COL_SURFACE, COL_BORDER, 1);

// ── Content ───────────────────────────────────────────
var _y  = panel_y + 70;
var _lx = panel_x + 32;
var _rx = panel_x + panel_w - 32;

// Game title
draw_set_font(fnt_bold_big);
draw_set_color(COL_ORANGE);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_cx, _y, "FOOD RUSH");
_y += 28;

draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(_cx, _y, "A Restaurant Management Game");
_y += 40;

// Divider
draw_set_color(COL_BORDER);
draw_set_alpha(0.5);
draw_line(_lx, _y, _rx, _y);
draw_set_alpha(1);
_y += 24;

// Assets title
draw_set_font(fnt_label);
draw_set_color(COL_YELLOW);
draw_set_halign(fa_center);
draw_text(_cx, _y, "ASSETS");
_y += 32;

// Rows
var _rows = [
    [COL_ORANGE, "Icons & Images",  "Flaticon",      "flaticon.com"],
    [COL_GREEN,  "Sound Effects",   "Freesound",     "freesound.org"],
    [COL_YELLOW, "Fonts",           "Google Fonts",  "fonts.google.com"],
];

for (var i = 0; i < array_length(_rows); i++) {
    var _row  = _rows[i];
    var _ry   = _y + i * 60;
    var _col  = _row[0];

    // Row bg
    draw_panel(_lx, _ry, _rx, _ry + 48, 10, COL_SURFACE2, COL_BORDER, 1);

    // Color bar ซ้าย
    draw_set_color(_col);
    draw_roundrect_ext(_lx, _ry, _lx + 6, _ry + 48, 10, 4, false);

    // Category
    draw_set_font(fnt_bold);
    draw_set_color(COL_TEXT);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_lx + 18, _ry + 8, _row[1]);

    // Source name
    draw_set_font(fnt_bold);
    draw_set_color(_col);
    draw_set_halign(fa_right);
    draw_text(_rx - 8, _ry + 5, _row[2]);

    // URL
    draw_set_font(fnt_tiny);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_text(_rx - 8, _ry + 28, _row[3]);
}
_y += array_length(_rows) * 60 + 16;

// Divider
draw_set_color(COL_BORDER);
draw_set_alpha(0.5);
draw_line(_lx, _y, _rx, _y);
draw_set_alpha(1);
_y += 16;

// Made with
draw_set_font(fnt_small);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_cx, _y, "Made with  GameMaker");

// ── Header วาดทับสุดท้าย ─────────────────────────────
draw_set_color(COL_SURFACE2);
draw_roundrect_ext(panel_x, panel_y, panel_x + panel_w, panel_y + 58, 20, 20, false);
draw_set_color(COL_SURFACE2);
draw_rectangle(panel_x, panel_y + 38, panel_x + panel_w, panel_y + 58, false);
draw_set_color(COL_BORDER);
draw_line(panel_x, panel_y + 58, panel_x + panel_w, panel_y + 58);

draw_set_font(fnt_title);
draw_set_color(COL_ORANGE);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, panel_y + 29, "Credits");

// Close button
var _xfill = close_hover ? COL_RED : make_color_rgb(60, 25, 0);
var _xbord  = close_hover ? COL_RED : COL_BORDER;
draw_panel(panel_x + panel_w - 44, panel_y + 10,
           panel_x + panel_w - 10, panel_y + 44,
           8, _xfill, _xbord, 1);
draw_set_font(fnt_bold_big);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(panel_x + panel_w - 27, panel_y + 27, "X");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
