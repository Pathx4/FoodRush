var _W = display_get_gui_width();
var _H = display_get_gui_height();

// Panel BG
draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h,
           14, make_color_rgb(20,10,0), COL_BORDER, 1);

// Header
draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + 40,
           14, COL_SURFACE, COL_BORDER, 1);
draw_set_font(fnt_bold);
draw_set_color(COL_TEXT);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(panel_x + 12, panel_y + 20, "Orders");

var _active_c = scr_orders_active_count();
if (_active_c > 0) {
    draw_roundrect_color_custom(panel_x + panel_w - 34, panel_y + 8,
                                panel_x + panel_w - 6,  panel_y + 32,
                                10, COL_ORANGE, 1);
    draw_set_font(fnt_small);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(panel_x + panel_w - 20, panel_y + 20, string(_active_c));
}

// ── Admin autofill indicator ──────────────────────────
if (variable_global_exists("admin_autofill") && global.admin_autofill) {
    draw_set_font(fnt_tiny);
    draw_set_color(make_color_rgb(100, 255, 120));
    draw_set_halign(fa_right);
    draw_text(panel_x + panel_w - 42, panel_y + 14, "AUTO");
}

if (_active_c == 0) {
    draw_set_font(fnt_italic);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_center);
    draw_text(panel_x + panel_w * 0.5, panel_y + 60, "Waiting for customers...");
}

// ── Cards ─────────────────────────────────────────────
var _card_y = panel_y + 46;
var _drawn  = 0;

for (var i = 0; i < array_length(global.orders); i++) {
    var _o = global.orders[i];
    if (_o.state != ORDER_STATE.WAITING) continue;

    var _cx1 = panel_x + 6;
    var _cy1 = _card_y + _drawn * (card_h + card_gap);
    var _cx2 = panel_x + panel_w - 6;
    var _cy2 = _cy1 + card_h;

    if (_cy1 + card_h > panel_y + panel_h) break;
    _drawn++;

    // Timer
    var _pct    = _o.time_left / _o.recipe.time_limit;
    var _urgent = (_pct < 0.3);
    var _t_col;
    if (_pct > 0.6) {
        _t_col = COL_GREEN;
    } else if (_pct > 0.3) {
        _t_col = COL_ORANGE;
    } else {
        _t_col = COL_RED;
    }

    var _match = scr_tray_matches(global.tray, _o.recipe.ingredients);
    var _fill  = _match ? merge_color(COL_SURFACE, COL_GREEN, 0.12) : COL_SURFACE;
    var _bord;
    if (_urgent) {
        _bord = COL_RED;
    } else if (_match) {
        _bord = COL_GREEN;
    } else {
        _bord = COL_BORDER;
    }

    draw_panel(_cx1, _cy1, _cx2, _cy2, 12, _fill, _bord, 1);

    // Urgent glow
    if (_urgent) {
        var _ga = 0.2 + sin(current_time * 0.008) * 0.12;
        draw_set_alpha(_ga);
        draw_set_color(COL_RED);
        draw_roundrect_ext(_cx1 - 2, _cy1 - 2, _cx2 + 2, _cy2 + 2, 14, 14, true);
        draw_set_alpha(1);
    }

    // ── Row 1: Avatar + ชื่อ + เมนู ──────────────────
    var _row1_y = _cy1 + 10;

    if (sprite_exists(_o.avatar_spr)) {
        var _aw = sprite_get_width(_o.avatar_spr);
        var _ah = sprite_get_height(_o.avatar_spr);
        draw_sprite_ext(_o.avatar_spr, 0,
            _cx1 + 16 - _aw * 0.5 * 0.55,
            _row1_y + 12 - _ah * 0.5 * 0.55,
            0.55, 0.55, 0, c_white, 1);
    }

    draw_set_font(fnt_bold);
    draw_set_color(COL_TEXT);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_cx1 + 38, _row1_y - 5, _o.customer);

    draw_set_font(fnt_small);
    draw_set_color(COL_TEXT2);
    draw_text(_cx1 + 38, _row1_y + 20, _o.recipe.name);

    // ── Admin autofill hint บนการ์ด ──────────────────
    if (variable_global_exists("admin_autofill") && global.admin_autofill) {
        draw_set_font(fnt_tiny);
        draw_set_color(make_color_rgb(80, 200, 100));
        draw_set_halign(fa_right);
        draw_text(_cx2 - 6, _row1_y, "click to fill");
    }

    // ── Row 2: Ingredient icons ────────────────────────
    var _ings     = _o.recipe.ingredients;
    var _ing_size = 30;
    var _ing_gap  = 4;
    var _ing_y    = _cy1 + 60;
    var _ing_x    = _cx1 + 4;

    for (var j = 0; j < array_length(_ings); j++) {
        var _id  = _ings[j];
        var _ing = global.ing[_id];

        var _in_tray = false;
        for (var t = 0; t < array_length(global.tray); t++) {
            if (global.tray[t] == _id) { _in_tray = true; break; }
        }

        var _jx   = _ing_x + j * (_ing_size + _ing_gap);
        var _jy   = _ing_y;
        var _jcol = _in_tray ? make_color_rgb(30,70,30) : COL_SURFACE2;
        var _jbrd = _in_tray ? COL_GREEN : COL_BORDER;

        draw_panel(_jx, _jy, _jx + _ing_size, _jy + _ing_size, 5, _jcol, _jbrd, 1);

        if (sprite_exists(_ing.spr)) {
            draw_sprite_ext(_ing.spr, 0,
                _jx + _ing_size - 28,
                _jy + _ing_size - 29,
                0.42, 0.42, 0, c_white, 1);
        }
    }

    // ── Row 3: Points + Time + Timer bar ──────────────
    draw_set_font(fnt_tiny);
    draw_set_color(COL_YELLOW);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_cx1 + 6, _cy2 - 30, string(_o.recipe.points) + " pts");

    draw_set_halign(fa_right);
    draw_set_color(_urgent ? COL_RED : COL_TEXT2);
    draw_text(_cx2 - 6, _cy2 - 24, _urgent ? "URGENT!" : (string(ceil(_o.time_left)) + "s"));

    draw_progress_bar(_cx1 + 6, _cy2 - 10,
                      (_cx2 - _cx1) - 12, 7,
                      _pct, COL_SURFACE2, _t_col, 3);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);