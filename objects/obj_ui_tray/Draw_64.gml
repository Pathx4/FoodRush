var _tray_len  = array_length(global.tray);
var _btn_h     = 44;
var _tray_area = tray_item_size + 45;
var _panel_h   = 26 + _tray_area + _btn_h + 16;

// Panel background
draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + _panel_h,
           14, COL_SURFACE, COL_BORDER, 1);

// Section label
draw_set_font(fnt_label);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(panel_x + 10, panel_y + 7, "ASSEMBLY TRAY");

// ── Tray items ────────────────────────────────────────
var _items_y = panel_y + 28;
var _max_items = floor((panel_w - 16) / (tray_item_size + tray_item_gap));

if (_tray_len == 0) {
    draw_set_font(fnt_italic);
    draw_set_color(COL_BORDER);
    draw_set_halign(fa_left);
    draw_text(panel_x + 14, _items_y + 14, "Click ingredients above to add...");
} else {
    for (var i = 0; i < _tray_len; i++) {
        var _id  = global.tray[i];
        var _ing = global.ing[_id];

        // จำกัดไม่ให้ overflow นอก panel
        var _ix = panel_x + 8 + i * (tray_item_size + tray_item_gap);
        if (_ix + tray_item_size > panel_x + panel_w - 8) break;

        var _iy = _items_y + 5;

        // Item background chip
        draw_panel(_ix, _iy, _ix + tray_item_size, _iy + tray_item_size,
                   10, COL_SURFACE2, COL_BORDER, 1);

        // Sprite กึ่งกลาง chip
        if (sprite_exists(_ing.spr)) {
            draw_sprite_ext(_ing.spr, 0,
                _ix + tray_item_size - 46.5,
                _iy + tray_item_size - 48,
                0.65, 0.65, 0, c_white, 1);
        }
    }
}

// ── Match label ───────────────────────────────────────
var _can_serve    = (matched_recipe_id != -1);
var _label_y      = _items_y + tray_item_size + 6;
if (_can_serve) {
    var _rec = global.recipe[matched_recipe_id];
    draw_set_font(fnt_small);
    draw_set_color(COL_GREEN);
    draw_set_halign(fa_left);
    draw_text(panel_x + 10, _label_y, "Match: " + _rec.name);
} else if (_tray_len > 0) {
    draw_set_font(fnt_small);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_left);
    draw_text(panel_x + 10, _label_y, "No matching order...");
}

// ── Serve button ──────────────────────────────────────
var _serve_bx = panel_x + 8;
var _serve_by = panel_y + _panel_h - _btn_h - 8;
var _serve_bw = panel_w - 90;

var _sb_fill = _can_serve ? COL_GREEN : COL_BORDER;
if (_can_serve && serve_hover) _sb_fill = make_color_rgb(56,200,60);

var _sw  = _serve_bw * serve_scale;
var _sh  = _btn_h    * serve_scale;
var _scx = _serve_bx + _serve_bw * 0.5;
var _scy = _serve_by + _btn_h    * 0.5;

draw_panel(_scx - _sw * 0.5, _scy - _sh * 0.5,
           _scx + _sw * 0.5, _scy + _sh * 0.5,
           12, _sb_fill, _sb_fill, 1);

draw_set_font(fnt_bold);
draw_set_color(_can_serve ? c_white : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _serve_label = _can_serve ? ("Serve - " + global.recipe[matched_recipe_id].name) : "Serve Dish";
draw_text(_scx, _scy, _serve_label);

// ── Clear button ──────────────────────────────────────
var _clear_bx = _serve_bx + _serve_bw + 8;
var _clear_bw = panel_w - _serve_bw - 24;
var _clear_by = _serve_by;

var _cb_fill = clear_hover ? make_color_rgb(180,40,40) : COL_SURFACE2;
var _cb_bord = clear_hover ? COL_RED : COL_BORDER;

draw_panel(_clear_bx, _clear_by,
           _clear_bx + _clear_bw, _clear_by + _btn_h,
           12, _cb_fill, _cb_bord, 1);

draw_set_font(fnt_bold);
draw_set_color(clear_hover ? c_white : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_clear_bx + _clear_bw * 0.5, _clear_by + _btn_h * 0.5, "Clear");

draw_set_halign(fa_left);
draw_set_valign(fa_top);