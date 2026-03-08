var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = panel_x + panel_w * 0.5;

// Dim BG
draw_set_color(c_black);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

// Panel BG
draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h,
           20, COL_SURFACE, COL_BORDER, 1);

// ── Clip zone ─────────────────────────────────────────
var _clip_y1 = panel_y + 60;   // ใต้ header
var _clip_y2 = panel_y + panel_h - 8;
var _sy      = _clip_y1 - scroll_y;

// ── Section 1: Objective ──────────────────────────────
var _y = _sy + 16;
if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "OBJECTIVE", COL_ORANGE);
}
_y += 36;

if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_set_font(fnt_small);
    draw_set_color(COL_TEXT);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_ext(_cx, _y,
        "Take orders from customers, pick the right\ningredients, and serve before time runs out!",
        22, panel_w - 40);
}
_y += 64;

if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_set_color(COL_BORDER); draw_set_alpha(0.5);
    draw_line(panel_x + 20, _y, panel_x + panel_w - 20, _y);
    draw_set_alpha(1);
}
_y += 16;

// ── Section 2: Gameplay ───────────────────────────────
if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "GAMEPLAY", COL_GREEN);
}
_y += 36;

var _steps = [
    ["1", "Check the Orders",  "Orders appear on the right side.\nEach shows the required ingredients."],
    ["2", "Pick Ingredients",  "Tap ingredient buttons on the left\nto add them to your tray."],
    ["3", "Serve the Dish",    "Press Serve Dish once all ingredients\nare on the tray."],
    ["4", "Watch the Timer!",  "A red bar means the order is\nabout to expire - hurry up!"],
];

for (var i = 0; i < array_length(_steps); i++) {
    var _step   = _steps[i];
    var _item_y = _y + i * 90;
    if (_item_y >= _clip_y1 && _item_y < _clip_y2) {
        draw_panel(panel_x + 20, _item_y, panel_x + 52, _item_y + 32,
                   8, COL_ORANGE, COL_ORANGE, 1);
        draw_set_font(fnt_bold_big);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(panel_x + 36, _item_y + 16, _step[0]);

        draw_set_font(fnt_bold);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(panel_x + 62, _item_y + 2, _step[1]);

        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT2);
        draw_text_ext(panel_x + 62, _item_y + 24, _step[2], 18, panel_w - 82);
    }
}
_y += array_length(_steps) * 90 + 8;

if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_set_color(COL_BORDER); draw_set_alpha(0.5);
    draw_line(panel_x + 20, _y, panel_x + panel_w - 20, _y);
    draw_set_alpha(1);
}
_y += 16;

// ── Section 3: Scoring ────────────────────────────────
if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "SCORING", COL_YELLOW);
}
_y += 36;

var _score_items = [
    [COL_GREEN,  "Successful Serve", "+100 pts or more per dish"],
    [COL_ORANGE, "Combo",            "Serve in a row for x2, x3 bonus!"],
    [COL_YELLOW, "Tip",              "Serve fast to earn extra tips"],
    [COL_RED,    "Order Expired",    "-1 Life"],
];

for (var i = 0; i < array_length(_score_items); i++) {
    var _item = _score_items[i];
    var _iy   = _y + i * 44;
    if (_iy >= _clip_y1 && _iy < _clip_y2) {
        draw_panel(panel_x + 20, _iy, panel_x + panel_w - 20, _iy + 36,
                   8, COL_SURFACE2, COL_BORDER, 1);
        draw_set_color(_item[0]);
        draw_circle(panel_x + 38, _iy + 18, 6, false);
        draw_set_font(fnt_bold);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(panel_x + 52, _iy + 18, _item[1]);
        draw_set_font(fnt_small);
        draw_set_color(_item[0]);
        draw_set_halign(fa_right);
        draw_text(panel_x + panel_w - 28, _iy + 18, _item[2]);
    }
}
_y += array_length(_score_items) * 44 + 8;

if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_set_color(COL_BORDER); draw_set_alpha(0.5);
    draw_line(panel_x + 20, _y, panel_x + panel_w - 20, _y);
    draw_set_alpha(1);
}
_y += 16;

// ── Section 4: Stars ──────────────────────────────────
if (_y >= _clip_y1 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "STARS", COL_YELLOW);
}
_y += 36;

var _star_rows = [
    [3, "Top score - Perfect Chef!"],
    [2, "Good score - Well done!"],
    [1, "Minimum score - Level cleared"],
];

for (var i = 0; i < array_length(_star_rows); i++) {
    var _row = _star_rows[i];
    var _ry  = _y + i * 44;
    if (_ry >= _clip_y1 && _ry < _clip_y2) {
        draw_panel(panel_x + 20, _ry, panel_x + panel_w - 20, _ry + 36,
                   8, COL_SURFACE2, COL_BORDER, 1);
        var _star_num = _row[0];
        for (var s = 0; s < 3; s++) {
            var _sx  = panel_x + 25 + s * 22;
            var _sy2 = _ry + 7;
            draw_set_alpha((s < _star_num) ? 1.0 : 0.25);
            if (sprite_exists(spr_star_on) && s < _star_num) {
                draw_sprite_ext(spr_star_on, 0, _sx, _sy2, 0.55, 0.55, 0, c_white, 1);
            } else if (sprite_exists(spr_star_off)) {
                draw_sprite_ext(spr_star_off, 0, _sx, _sy2, 0.55, 0.55, 0, c_white, 1);
            } else {
                draw_set_color((s < _star_num) ? COL_YELLOW : COL_SURFACE2);
                draw_circle(_sx, _sy2 + 8, 8, false);
            }
        }
        draw_set_alpha(1);
        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(panel_x + 100, _ry + 18, _row[1]);
    }
}
_y += array_length(_star_rows) * 44 + 20;

// Update content height
content_h = _y - _sy + scroll_y;

// Scrollbar
var _max_scroll2 = max(0, content_h - panel_h + 80);
if (_max_scroll2 > 0) {
    var _track_h  = panel_h - 70;
    var _track_x  = panel_x + panel_w - 10;
    var _track_y1 = panel_y + 62;
    var _track_y2 = _track_y1 + _track_h;
    draw_set_color(COL_SURFACE2);
    draw_set_alpha(0.5);
    draw_roundrect_ext(_track_x - 4, _track_y1, _track_x, _track_y2, 2, 2, false);
    draw_set_alpha(1);
    var _thumb_pct = scroll_y / _max_scroll2;
    var _thumb_h   = max(30, _track_h * (panel_h / (content_h + 80)));
    var _thumb_y   = _track_y1 + (_track_h - _thumb_h) * _thumb_pct;
    draw_set_color(COL_ORANGE);
    draw_roundrect_ext(_track_x - 4, _thumb_y, _track_x, _thumb_y + _thumb_h, 2, 2, false);
}

if (_max_scroll2 > 0 && scroll_y < 10) {
    draw_set_font(fnt_tiny);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_cx, _clip_y2 - 20, "scroll down for more");
}

// ── Header วาดทับสุดท้าย — ป้องกัน content ทะลุขึ้นมา ──
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
draw_text(_cx - 20, panel_y + 29, "How To Play");

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