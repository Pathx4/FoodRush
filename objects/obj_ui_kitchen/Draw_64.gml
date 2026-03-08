if (global.game_state == GAME_STATE.RESULT) exit;

var _cx = kitchen_x + kitchen_w * 0.5;
var _cy = kitchen_y + kitchen_h * 0.5;

// Panel BG
draw_panel(kitchen_x, kitchen_y,
           kitchen_x + kitchen_w, kitchen_y + kitchen_h,
           14, make_color_rgb(15, 7, 0), COL_BORDER, 1);

// ── ACTIVE ORDER (ใหญ่ ตรงกลาง บน) ───────────────────
// หา order ที่เหลือเวลาน้อยที่สุด (urgent ที่สุด)
var _focus_idx = -1;
var _min_time  = 9999;
for (var i = 0; i < array_length(global.orders); i++) {
    var _o = global.orders[i];
    if (_o.state == ORDER_STATE.WAITING && _o.time_left < _min_time) {
        _min_time  = _o.time_left;
        _focus_idx = i;
    }
}

var _focus_y = kitchen_y + 16;
var _focus_h = kitchen_h * 0.52;

if (_focus_idx >= 0) {
    var _fo   = global.orders[_focus_idx];
    var _fpct = _fo.time_left / _fo.recipe.time_limit;
    var _furg = (_fpct < 0.3);

    // Card ใหญ่
    var _fc_x1 = kitchen_x + 16;
    var _fc_y1 = _focus_y;
    var _fc_x2 = kitchen_x + kitchen_w - 16;
    var _fc_y2 = _focus_y + _focus_h;
    var _fcx   = (_fc_x1 + _fc_x2) * 0.5;

    var _ft_col;
    if (_fpct > 0.6) {
        _ft_col = COL_GREEN;
    } else if (_fpct > 0.3) {
        _ft_col = COL_ORANGE;
    } else {
        _ft_col = COL_RED;
    }

    var _match = scr_tray_matches(global.tray, _fo.recipe.ingredients);
    var _ffill = _match ? merge_color(COL_SURFACE, COL_GREEN, 0.15) : COL_SURFACE;
    var _fbord = _furg ? COL_RED : (_match ? COL_GREEN : COL_BORDER);

    draw_panel(_fc_x1, _fc_y1, _fc_x2, _fc_y2, 16, _ffill, _fbord, 1);

    // Urgent pulse
    if (_furg) {
        var _pa = 0.15 + sin(anim_timer * 0.12) * 0.1;
        draw_set_alpha(_pa);
        draw_set_color(COL_RED);
        draw_roundrect_ext(_fc_x1 - 2, _fc_y1 - 2, _fc_x2 + 2, _fc_y2 + 2, 18, 18, true);
        draw_set_alpha(1);
    }

    // "ACTIVE ORDER" label
    draw_set_font(fnt_label);
    draw_set_color(_furg ? COL_RED : COL_TEXT2);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_fc_x1 + 5, _fc_y1 + 10, _furg ? "URGENT ORDER" : "ACTIVE ORDER");

    // Avatar + ชื่อลูกค้า
    if (sprite_exists(_fo.avatar_spr)) {
        var _aw = sprite_get_width(_fo.avatar_spr);
        var _ah = sprite_get_height(_fo.avatar_spr);
        draw_sprite_ext(_fo.avatar_spr, 0,
            _fc_x1 + 25 - _aw * 0.5 * 0.85,
            _fc_y1 + 55 - _ah * 0.5 * 0.85,
            0.85, 0.85, 0, c_white, 1);
    }
    draw_set_font(fnt_bold_big);
    draw_set_color(COL_TEXT);
    draw_set_halign(fa_left);
    draw_text(_fc_x1 + 52, _fc_y1 + 40, _fo.customer);

    // ชื่อเมนูใหญ่
    draw_set_font(fnt_title);
    draw_set_color(COL_ORANGE);
    draw_set_halign(fa_center);
    draw_text(_fcx, _fc_y1 + 76, _fo.recipe.name);

    // Dish sprite (ถ้ามี)
    if (sprite_exists(_fo.recipe.spr)) {
        draw_sprite_ext(_fo.recipe.spr, 0,
            _fcx - 71, _fc_y1 + 130,
            1.4, 1.4, 0, c_white, 1);
    }

    // Ingredient icons ใหญ่ขึ้น
    var _ings     = _fo.recipe.ingredients;
    var _ing_size = 44;
    var _ing_gap  = 8;
    var _ing_total = array_length(_ings) * (_ing_size + _ing_gap) - _ing_gap;
    var _ing_sx   = _fcx - _ing_total * 0.5;
    var _ing_y    = _fc_y2 - _ing_size - 44;

    for (var j = 0; j < array_length(_ings); j++) {
        var _id  = _ings[j];
        var _ing = global.ing[_id];
        var _jx  = _ing_sx + j * (_ing_size + _ing_gap);

        var _in_tray = false;
        for (var t = 0; t < array_length(global.tray); t++) {
            if (global.tray[t] == _id) { _in_tray = true; break; }
        }

        var _jfill = _in_tray ? make_color_rgb(30,80,30) : COL_SURFACE2;
        var _jbord = _in_tray ? COL_GREEN : COL_BORDER;
        draw_panel(_jx, _ing_y, _jx + _ing_size, _ing_y + _ing_size, 8, _jfill, _jbord, 1);

        if (sprite_exists(_ing.spr)) {
            var _sw = sprite_get_width(_ing.spr);
            var _sh = sprite_get_height(_ing.spr);
            var _sc = 0.6;
            draw_sprite_ext(_ing.spr, 0,
                _jx + _ing_size * 0.5 - _sw * 0.5 * _sc,
                _ing_y + _ing_size * 0.5 - _sh * 0.5 * _sc,
                _sc, _sc, 0, c_white, 1);
        }

        // Checkmark ถ้าอยู่ใน tray
        if (_in_tray) {
            draw_set_font(fnt_tiny);
            draw_set_color(COL_GREEN);
            draw_set_halign(fa_right);
            draw_text(_jx + _ing_size - 3, _ing_y + 2, "v");
        }

        // ชื่อ ingredient
        draw_set_font(fnt_tiny);
        draw_set_color(COL_TEXT2);
        draw_set_halign(fa_center);
        draw_text(_jx + _ing_size * 0.5, _ing_y + _ing_size + 2, _ing.name);
    }

    // Tip + Points
    draw_panel(_fc_x2 - 56, _fc_y1 + 8, _fc_x2 - 8, _fc_y1 + 30,
               6, make_color_rgb(40,30,0), COL_YELLOW, 1);
    draw_set_font(fnt_small);
    draw_set_color(COL_YELLOW);
    draw_set_halign(fa_center);
    draw_text((_fc_x2 - 56 + _fc_x2 - 8) * 0.5, _fc_y1 + 10, "$" + string(_fo.tip));

    // Timer bar
    draw_progress_bar(_fc_x1 + 12, _fc_y2 - 16,
                      (kitchen_w - 56), 8,
                      _fpct, COL_SURFACE2, _ft_col, 4);
    draw_set_font(fnt_small);
    draw_set_color(_ft_col);
    draw_set_halign(fa_right);
    draw_text(_fc_x2 - 12, _fc_y2 - 30,
              _furg ? "HURRY!" : (string(ceil(_fo.time_left)) + "s"));

} else {
    // ไม่มี order
    draw_set_font(fnt_bold);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_cx, kitchen_y + _focus_h * 0.5, "Waiting for customers...");
}

// ── STAT BOXES (ล่าง) ─────────────────────────────────
var _stats_y  = kitchen_y + _focus_h + 28;
var _stat_gap = kitchen_w / 3;

// SERVED
draw_panel(kitchen_x + 10,               _stats_y,
           kitchen_x + _stat_gap - 10,   _stats_y + 70,
           12, COL_SURFACE, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(kitchen_x + _stat_gap * 0.5, _stats_y + 10, "SERVED");
draw_set_font(fnt_bold_big);
draw_set_color(COL_GREEN);
draw_text(kitchen_x + _stat_gap * 0.5, _stats_y + 30, string(global.session_score div 100));

// COMBO
draw_panel(kitchen_x + _stat_gap + 10,      _stats_y,
           kitchen_x + _stat_gap * 2 - 10,  _stats_y + 70,
           12, COL_SURFACE, COL_BORDER, 1);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(kitchen_x + _stat_gap * 1.5, _stats_y + 10, "COMBO");
draw_set_font(fnt_bold_big);
draw_set_color((global.session_combo >= 3) ? COL_ORANGE : COL_TEXT);
draw_text(kitchen_x + _stat_gap * 1.5, _stats_y + 30, "x" + string(max(1, global.session_combo)));

// GOAL
draw_panel(kitchen_x + _stat_gap * 2 + 10, _stats_y,
           kitchen_x + kitchen_w - 10,      _stats_y + 70,
           12, COL_SURFACE, COL_BORDER, 1);
var _goal     = global.level_data[global.session_level_id].goal_score;
var _goal_pct = min(1.0, global.session_score / _goal);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(kitchen_x + _stat_gap * 2.5, _stats_y + 10, "GOAL");
draw_progress_bar(kitchen_x + _stat_gap * 2 + 14, _stats_y + 32,
                  (_stat_gap - 28), 12, _goal_pct, COL_SURFACE2, COL_ORANGE, 6);
draw_set_font(fnt_tiny);
draw_set_color(COL_TEXT2);
draw_text(kitchen_x + _stat_gap * 2.5, _stats_y + 50,
          string(global.session_score) + " / " + string(_goal));

// ── SERVE MSG FLASH ───────────────────────────────────
if (serve_msg_timer > 0 && serve_msg != "") {
    var _ma = min(1.0, serve_msg_timer / 30);
    draw_set_alpha(_ma);
    draw_set_font(fnt_bold_big);
    draw_set_color(COL_GREEN);
    draw_set_halign(fa_center);
    draw_text(_cx, kitchen_y + kitchen_h - 60, serve_msg);
    draw_set_alpha(1);
}

// ── COMBO FLASH ───────────────────────────────────────
if (combo_show_timer > 0 && combo_display >= 3) {
    var _ca = min(1.0, combo_show_timer / 30);
    draw_set_alpha(_ca);
    draw_set_font(fnt_title);
    draw_set_color(COL_ORANGE);
    draw_set_halign(fa_center);
    draw_text(_cx, kitchen_y + kitchen_h - 100, "COMBO x" + string(combo_display) + "!");
    draw_set_alpha(1);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);