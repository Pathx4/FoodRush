/// ============================================================
/// OBJECT: obj_ui_tray
/// PARENT: none  |  DEPTH: -90  |  VISIBLE: true
/// Place in rm_game on layer "UI"
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    panel_x  = 8;
    panel_y  = display_get_gui_height() - 170;
    panel_w  = 420;
    panel_h  = 162;

    serve_bx = panel_x + 8;
    serve_by = panel_y + panel_h - 52;
    serve_bw = 280;
    serve_bh = 44;

    clear_bx = serve_bx + serve_bw + 8;
    clear_by = serve_by;
    clear_bw = panel_w - serve_bw - 24;
    clear_bh = 44;

    serve_hover = false;
    clear_hover = false;
    serve_scale = 1.0;

    // Match detection
    matched_recipe_id = -1;
*/

// ╔══════════════════════════════════════════════════════╗
// ║  USER EVENT 0 — Refresh tray display & match check   ║
// ╚══════════════════════════════════════════════════════╝
/*
    matched_recipe_id = -1;
    // Check if current tray matches any waiting order
    for (var i = 0; i < array_length(global.orders); i++) {
        var _o = global.orders[i];
        if (_o.state == ORDER_STATE.WAITING) {
            if (scr_tray_matches(global.tray, _o.recipe.ingredients)) {
                matched_recipe_id = _o.recipe_id;
                break;
            }
        }
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (global.game_state != GAME_STATE.PLAYING) exit;

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    serve_hover = point_in_rectangle(_mx, _my, serve_bx, serve_by, serve_bx + serve_bw, serve_by + serve_bh);
    clear_hover = point_in_rectangle(_mx, _my, clear_bx, clear_by, clear_bx + clear_bw, clear_by + clear_bh);

    var _can_serve = (matched_recipe_id != -1);
    var _target_scale = (serve_hover && _can_serve) ? 1.04 : 1.0;
    serve_scale = lerp(serve_scale, _target_scale, 0.2);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, 16, COL_SURFACE, COL_BORDER, 1);

    // Section label
    draw_set_font(fnt_label);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_left);
    draw_text(panel_x + 12, panel_y + 8, "🍳  ASSEMBLY TRAY");

    // Tray items
    var _tray_len = array_length(global.tray);
    if (_tray_len == 0) {
        draw_set_color(COL_BORDER);
        draw_set_font(fnt_italic);
        draw_set_halign(fa_left);
        draw_text(panel_x + 12, panel_y + 40, "Click ingredients above to add...");
    } else {
        var _item_size = 48;
        var _item_gap  = 6;
        for (var i = 0; i < _tray_len; i++) {
            var _id  = global.tray[i];
            var _ing = global.ing[_id];
            var _ix  = panel_x + 12 + i * (_item_size + _item_gap);
            var _iy  = panel_y + 30;

            // Background chip
            draw_panel(_ix, _iy, _ix + _item_size, _iy + _item_size, 10, COL_SURFACE2, COL_BORDER, 1);

            // Sprite
            if (sprite_exists(_ing.spr)) {
                draw_sprite_scaled(_ing.spr, 0, _ix + _item_size * 0.5, _iy + _item_size * 0.5, 0.7, 0.7);
            }
        }
    }

    // Matched dish preview
    if (matched_recipe_id != -1) {
        var _rec = global.recipe[matched_recipe_id];
        draw_set_font(fnt_bold);
        draw_set_color(COL_GREEN);
        draw_set_halign(fa_left);
        draw_text(panel_x + 12, panel_y + panel_h - 62, "✓ " + _rec.name);
    }

    // ── Serve button ─────────────────────────────────────
    var _can_serve = (matched_recipe_id != -1);
    var _sb_col    = _can_serve ? (_serve_hover ? make_color_rgb(56,200,60) : COL_GREEN) : COL_BORDER;
    var _sb_text_col = _can_serve ? c_white : COL_TEXT2;

    var _sw = serve_bw * serve_scale;
    var _sh = serve_bh * serve_scale;
    var _scx = serve_bx + serve_bw * 0.5;
    var _scy = serve_by + serve_bh * 0.5;

    draw_panel(_scx - _sw * 0.5, _scy - _sh * 0.5, _scx + _sw * 0.5, _scy + _sh * 0.5, 12, _sb_col, _sb_col, 1);
    draw_set_font(fnt_bold);
    draw_set_color(_sb_text_col);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var _serve_label = _can_serve ? ("✅ Serve — " + global.recipe[matched_recipe_id].name) : "✅ Serve Dish";
    draw_text(_scx, _scy, _serve_label);

    // ── Clear button ─────────────────────────────────────
    var _cb_col = clear_hover ? COL_RED : COL_SURFACE2;
    draw_panel(clear_bx, clear_by, clear_bx + clear_bw, clear_by + clear_bh, 12, _cb_col, COL_BORDER, 1);
    draw_set_font(fnt_bold);
    draw_set_color(clear_hover ? c_white : COL_TEXT2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(clear_bx + clear_bw * 0.5, clear_by + clear_bh * 0.5, "🗑 Clear");

    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT                                  ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (global.game_state != GAME_STATE.PLAYING) exit;

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Serve button
    if (serve_hover && matched_recipe_id != -1) {
        serve_scale = 0.94;
        scr_serve_dish();
        return;
    }

    // Clear button
    if (clear_hover) {
        global.tray = [];
        matched_recipe_id = -1;
        play_sound(SND_CLICK);
        with (obj_ui_orders) { event_user(0); }
        return;
    }

    // Click on tray items to remove them
    var _tray_len = array_length(global.tray);
    var _item_size = 48;
    var _item_gap  = 6;
    for (var i = 0; i < _tray_len; i++) {
        var _ix = panel_x + 12 + i * (_item_size + _item_gap);
        var _iy = panel_y + 30;
        if (point_in_rectangle(_mx, _my, _ix, _iy, _ix + _item_size, _iy + _item_size)) {
            array_delete(global.tray, i, 1);
            event_user(0);
            with (obj_ui_orders) { event_user(0); }
            play_sound(SND_CLICK);
            break;
        }
    }
*/
