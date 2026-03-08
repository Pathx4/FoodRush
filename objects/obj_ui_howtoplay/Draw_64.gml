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

// ── Header (ไม่ scroll) ───────────────────────────────
draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + 54,
           20, COL_SURFACE2, COL_BORDER, 1);
draw_set_font(fnt_title);
draw_set_color(COL_ORANGE);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, panel_y + 27, "How To Play");

// Close button X
var _xfill = close_hover ? COL_RED : COL_SURFACE2;
draw_panel(panel_x + panel_w - 40, panel_y + 8,
           panel_x + panel_w - 8,  panel_y + 40,
           8, _xfill, COL_BORDER, 1);
draw_set_font(Thai);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(panel_x + panel_w - 24, panel_y + 24, "X");

// ── Scrollable content ────────────────────────────────
// clip area เริ่มหลัง header
var _clip_y1 = panel_y + 54;
var _clip_y2 = panel_y + panel_h - 8;
var _sy      = _clip_y1 - scroll_y;  // offset สำหรับ scroll

// helper macro สำหรับวาดข้อความ
// _sy จะขยับตาม scroll

// ── Section 1: เป้าหมาย ───────────────────────────────
var _y = _sy + 16;

if (_y > _clip_y1 - 60 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "OBJECTIVE", COL_ORANGE);
}
_y += 36;

if (_y > _clip_y1 - 80 && _y < _clip_y2) {
    draw_set_font(ThaiSmall);
    draw_set_color(COL_TEXT);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_ext(_cx, _y,
        "รับออร์เดอร์จากลูกค้า เลือกส่วนผสม\nให้ตรงกับเมนูที่สั่ง แล้วกด Serve\nก่อนเวลาหมด!",
        22, panel_w - 40);
}
_y += 78;

// ── Divider ───────────────────────────────────────────
if (_y > _clip_y1 && _y < _clip_y2) {
    draw_set_color(COL_BORDER);
    draw_set_alpha(0.5);
    draw_line(panel_x + 20, _y, panel_x + panel_w - 20, _y);
    draw_set_alpha(1);
}
_y += 16;

// ── Section 2: วิธีเล่น ───────────────────────────────
if (_y > _clip_y1 - 60 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "GAMEPLAY", COL_GREEN);
}
_y += 36;

var _steps = [
    ["1", "ดูออร์เดอร์ลูกค้า", "ฝั่งขวา Orders จะแสดงชื่อเมนู\nและส่วนผสมที่ต้องการ"],
    ["2", "เลือกส่วนผสม", "กดที่ปุ่ม INGREDIENTS\nด้านซ้ายเพื่อเพิ่มลงถาด"],
    ["3", "เสิร์ฟอาหาร", "กด Serve Dish เมื่อเลือก\nส่วนผสมครบถ้วนแล้ว"],
    ["4", "ระวังเวลา!", "แถบสีแดงหมายถึงออร์เดอร์\nกำลังจะหมดเวลา"],
];

for (var i = 0; i < array_length(_steps); i++) {
    var _step = _steps[i];
    var _item_y = _y + i * 90;

    if (_item_y > _clip_y1 - 80 && _item_y < _clip_y2) {
        // Number badge
        draw_panel(panel_x + 20, _item_y,
                   panel_x + 52, _item_y + 32,
                   8, COL_ORANGE, COL_ORANGE, 1);
        draw_set_font(ThaiBig);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(panel_x + 36, _item_y + 16, _step[0]);

        // Step title
        draw_set_font(Thai);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(panel_x + 62, _item_y + 2, _step[1]);

        // Step description
        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT2);
        draw_text_ext(panel_x + 62, _item_y + 24, _step[2], 18, panel_w - 82);
    }
}
_y += array_length(_steps) * 90 + 8;

// ── Divider ───────────────────────────────────────────
if (_y > _clip_y1 && _y < _clip_y2) {
    draw_set_color(COL_BORDER);
    draw_set_alpha(0.5);
    draw_line(panel_x + 20, _y, panel_x + panel_w - 20, _y);
    draw_set_alpha(1);
}
_y += 16;

// ── Section 3: คะแนน ─────────────────────────────────
if (_y > _clip_y1 - 60 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "SCORING", COL_YELLOW);
}
_y += 36;

var _score_items = [
    [COL_GREEN,  "Serve สำเร็จ",    "+100 pts ขึ้นไปต่อจาน"],
    [COL_ORANGE, "Combo",           "เสิร์ฟต่อเนื่องได้ bonus x2 x3!"],
    [COL_YELLOW, "Tip",             "เสิร์ฟเร็วได้ Tip เพิ่ม"],
    [COL_RED,    "Order หมดเวลา",   "-1 Lives"],
];

for (var i = 0; i < array_length(_score_items); i++) {
    var _item  = _score_items[i];
    var _iy    = _y + i * 44;

    if (_iy > _clip_y1 - 40 && _iy < _clip_y2) {
        draw_panel(panel_x + 20, _iy, panel_x + panel_w - 20, _iy + 36,
                   8, COL_SURFACE2, COL_BORDER, 1);

        // Color dot
        draw_set_color(_item[0]);
        draw_circle(panel_x + 38, _iy + 18, 6, false);

        // Label
        draw_set_font(fnt_bold);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(panel_x + 52, _iy + 18, _item[1]);

        // Value
        draw_set_font(fnt_small);
        draw_set_color(_item[0]);
        draw_set_halign(fa_right);
        draw_text(panel_x + panel_w - 28, _iy + 18, _item[2]);
    }
}
_y += array_length(_score_items) * 44 + 8;

// ── Divider ───────────────────────────────────────────
if (_y > _clip_y1 && _y < _clip_y2) {
    draw_set_color(COL_BORDER);
    draw_set_alpha(0.5);
    draw_line(panel_x + 20, _y, panel_x + panel_w - 20, _y);
    draw_set_alpha(1);
}
_y += 16;

// ── Section 4: ดาว ────────────────────────────────────
if (_y > _clip_y1 - 60 && _y < _clip_y2) {
    draw_section_header(_cx, _y, "STARS", COL_YELLOW);
}
_y += 36;

var _star_rows = [
    [3, "คะแนนสูงสุด — Perfect Chef!"],
    [2, "ผ่านด้วยคะแนนดี"],
    [1, "ผ่านเกณฑ์ขั้นต่ำ"],
];

for (var i = 0; i < array_length(_star_rows); i++) {
    var _row = _star_rows[i];
    var _ry  = _y + i * 44;

    if (_ry > _clip_y1 - 40 && _ry < _clip_y2) {
        draw_panel(panel_x + 20, _ry, panel_x + panel_w - 20, _ry + 36,
                   8, COL_SURFACE2, COL_BORDER, 1);

        // Stars
        var _star_num = _row[0];
        for (var s = 0; s < 3; s++) {
            var _sc = (s < _star_num) ? COL_YELLOW : COL_SURFACE;
            draw_set_color(_sc);
            draw_set_alpha((s < _star_num) ? 1.0 : 0.3);
            if (sprite_exists(spr_star_on) && s < _star_num) {
                draw_sprite_ext(spr_star_on, 0,
                    panel_x + 36 + s * 22, _ry + 18,
                    0.55, 0.55, 0, c_white, 1);
            } else {
                draw_roundrect_ext(
                    panel_x + 26 + s * 22, _ry + 9,
                    panel_x + 44 + s * 22, _ry + 27,
                    3, 3, false);
            }
        }
        draw_set_alpha(1);

        // Label
        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(panel_x + 96, _ry + 18, _row[1]);
    }
}
_y += array_length(_star_rows) * 44 + 20;

// อัปเดต content_h จริง
content_h = _y - _sy + scroll_y;

// ── Scroll indicator ─────────────────────────────────
var _max_scroll2 = max(0, content_h - panel_h + 80);
if (_max_scroll2 > 0) {
    var _track_h  = panel_h - 70;
    var _track_x  = panel_x + panel_w - 10;
    var _track_y1 = panel_y + 58;
    var _track_y2 = _track_y1 + _track_h;

    // Track
    draw_set_color(COL_SURFACE2);
    draw_set_alpha(0.5);
    draw_roundrect_ext(_track_x - 4, _track_y1, _track_x, _track_y2, 2, 2, false);
    draw_set_alpha(1);

    // Thumb
    var _thumb_pct = scroll_y / _max_scroll2;
    var _thumb_h   = max(30, _track_h * (panel_h / (content_h + 80)));
    var _thumb_y   = _track_y1 + (_track_h - _thumb_h) * _thumb_pct;
    draw_set_color(COL_ORANGE);
    draw_roundrect_ext(_track_x - 4, _thumb_y, _track_x, _thumb_y + _thumb_h, 2, 2, false);
}

// ── Fade top/bottom edge ──────────────────────────────
// Fade บน
draw_set_color(COL_SURFACE);
for (var fi = 0; fi < 18; fi++) {
    draw_set_alpha((18 - fi) / 18 * 0.9);
    draw_line(panel_x + 2, _clip_y1 + fi, panel_x + panel_w - 12, _clip_y1 + fi);
}
// Fade ล่าง
for (var fi = 0; fi < 18; fi++) {
    draw_set_alpha(fi / 18 * 0.9);
    draw_line(panel_x + 2, _clip_y2 - fi, panel_x + panel_w - 12, _clip_y2 - fi);
}
draw_set_alpha(1);

// Scroll hint
if (_max_scroll2 > 0 && scroll_y < 10) {
    draw_set_font(fnt_tiny);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_cx, _clip_y2 - 20, "scroll down for more");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);