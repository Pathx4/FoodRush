/// ============================================================
/// OBJECT: obj_ui_orders
/// PARENT: none  |  DEPTH: -90  |  VISIBLE: true
/// Place in rm_game on layer "UI"
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    panel_x = display_get_gui_width() - 290;
    panel_y = 72;
    panel_w = 282;
    panel_h = display_get_gui_height() - panel_y - 8;

    card_h     = 120;
    card_gap   = 8;
    card_pad_x = 10;

    // Scroll offset (for future scrolling)
    scroll_y   = 0;

    // Order removal queue (orders that are done and fading out)
    // Each entry: { order_id, alpha, expire_timer }
    fade_queue = [];
*/

// ╔══════════════════════════════════════════════════════╗
// ║  USER EVENT 0 — Force visual refresh                 ║
// ╚══════════════════════════════════════════════════════╝
/*
    // Trigger after serve, fail, tray change
    // Nothing to recompute — orders list live-reads global.orders
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (global.game_state == GAME_STATE.RESULT) exit;

    // Move served/expired orders to fade queue, then clean up
    for (var i = array_length(global.orders) - 1; i >= 0; i--) {
        var _o = global.orders[i];
        if (_o.state == ORDER_STATE.SERVED || _o.state == ORDER_STATE.EXPIRED) {
            array_push(fade_queue, { order_ref: _o, alpha: 1.0 });
            array_delete(global.orders, i, 1);
        }
    }

    // Tick fade queue
    for (var i = array_length(fade_queue) - 1; i >= 0; i--) {
        fade_queue[i].alpha -= 0.05;
        if (fade_queue[i].alpha <= 0) {
            array_delete(fade_queue, i, 1);
        }
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _W = display_get_gui_width();
    var _H = display_get_gui_height();

    // Panel
    draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, 16, make_color_rgb(20, 10, 0), COL_BORDER, 1);

    // Header
    draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + 38, 16, COL_SURFACE, COL_BORDER, 1);
    draw_set_font(fnt_bold);
    draw_set_color(COL_TEXT);
    draw_set_halign(fa_left);
    draw_text(panel_x + 12, panel_y + 10, "📋 Orders");

    // Order count badge
    var _active_c = scr_orders_active_count();
    if (_active_c > 0) {
        draw_roundrect_color_custom(panel_x + panel_w - 36, panel_y + 8, panel_x + panel_w - 8, panel_y + 30, 10, COL_ORANGE, 1);
        draw_set_font(fnt_small);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(panel_x + panel_w - 22, panel_y + 10, string(_active_c));
    }

    // ── Draw order cards ─────────────────────────────────
    var _card_y = panel_y + 44;
    var _orders  = global.orders;

    if (array_length(_orders) == 0) {
        draw_set_font(fnt_italic);
        draw_set_color(COL_TEXT2);
        draw_set_halign(fa_center);
        draw_text(panel_x + panel_w * 0.5, _card_y + 20, "Waiting for customers...");
    }

    for (var i = 0; i < array_length(_orders); i++) {
        var _o = _orders[i];
        if (_o.state != ORDER_STATE.WAITING) continue;

        var _cx1 = panel_x + card_pad_x + _o.slide_offset;
        var _cy1 = _card_y + i * (card_h + card_gap);
        var _cx2 = panel_x + panel_w - card_pad_x + _o.slide_offset;
        var _cy2 = _cy1 + card_h;

        // Clip to panel
        gpu_set_scissor(panel_x, panel_y + 38, panel_w, panel_h - 38);

        // Tray match check
        var _match = scr_tray_matches(global.tray, _o.recipe.ingredients);

        // Time ratio
        var _pct  = _o.time_left / _o.recipe.time_limit;
        var _urgent = _pct < 0.3;
        var _t_col = (_pct > 0.6) ? COL_GREEN : (_pct > 0.3) ? COL_ORANGE : COL_RED;

        // Card fill
        var _fill = _match ? merge_color(COL_SURFACE, COL_GREEN, 0.15) : COL_SURFACE;
        var _bord = _urgent ? COL_RED : (_match ? COL_GREEN : COL_BORDER);
        draw_panel(_cx1, _cy1, _cx2, _cy2, 14, _fill, _bord, 1);

        // Urgent glow
        if (_urgent) {
            var _glow_alpha = 0.3 + sin(current_time * 0.008) * 0.2;
            draw_set_alpha(_glow_alpha);
            draw_set_color(COL_RED);
            draw_roundrect_ext(_cx1 - 2, _cy1 - 2, _cx2 + 2, _cy2 + 2, 16, 16, true);
            draw_set_alpha(1);
        }

        // Customer avatar sprite
        if (sprite_exists(_o.avatar_spr)) {
            draw_sprite_ext(_o.avatar_spr, 0, _cx1 + 20, _cy1 + 26, 1, 1, 0, c_white, 1);
        }

        // Customer name & dish
        draw_set_font(fnt_bold);
        draw_set_color(COL_TEXT);
        draw_set_halign(fa_left);
        draw_text(_cx1 + 46, _cy1 + 8, _o.customer);
        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT2);
        draw_text(_cx1 + 46, _cy1 + 26, _o.recipe.name);

        // Tip badge
        draw_panel(_cx2 - 42, _cy1 + 8, _cx2 - 4, _cy1 + 26, 8, make_color_rgb(40,30,0), COL_YELLOW, 1);
        draw_set_font(fnt_tiny);
        draw_set_color(COL_YELLOW);
        draw_set_halign(fa_center);
        draw_text((_cx2 - 42 + _cx2 - 4) * 0.5, _cy1 + 10, "$" + string(_o.tip));

        // Required ingredients
        var _ings = _o.recipe.ingredients;
        for (var j = 0; j < array_length(_ings); j++) {
            var _id  = _ings[j];
            var _ing = global.ing[_id];
            var _in_tray = false;
            for (var t = 0; t < array_length(global.tray); t++) {
                if (global.tray[t] == _id) { _in_tray = true; break; }
            }
            var _jx = _cx1 + 8 + j * 34;
            var _jy = _cy1 + 46;
            var _jcol = _in_tray ? make_color_rgb(40,80,40) : COL_SURFACE2;
            var _jbrd = _in_tray ? COL_GREEN : COL_BORDER;
            draw_panel(_jx, _jy, _jx + 30, _jy + 30, 6, _jcol, _jbrd, 1);
            if (sprite_exists(_ing.spr)) {
                draw_sprite_scaled(_ing.spr, 0, _jx + 15, _jy + 15, 0.55, 0.55);
            }
        }

        // Points
        draw_set_font(fnt_tiny);
        draw_set_color(COL_YELLOW);
        draw_set_halign(fa_left);
        draw_text(_cx1 + 8, _cy2 - 24, "⭐ " + string(_o.recipe.points) + " pts");

        // Time label
        draw_set_halign(fa_right);
        draw_set_color(_urgent ? COL_RED : COL_TEXT2);
        draw_text(_cx2 - 8, _cy2 - 24, _urgent ? "🔥 URGENT!" : ("⏱ " + string(ceil(_o.time_left)) + "s"));

        // Timer bar
        draw_progress_bar(_cx1 + 8, _cy2 - 10, (_cx2 - _cx1) - 16, 6, _pct, COL_SURFACE2, _t_col, 3);

        gpu_set_scissor_disable();
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT — click order to auto-fill tray  ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (global.game_state != GAME_STATE.PLAYING) exit;

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _card_y = panel_y + 44;
    for (var i = 0; i < array_length(global.orders); i++) {
        var _o = global.orders[i];
        if (_o.state != ORDER_STATE.WAITING) continue;

        var _cx1 = panel_x + card_pad_x + _o.slide_offset;
        var _cy1 = _card_y + i * (card_h + card_gap);
        var _cx2 = panel_x + panel_w - card_pad_x + _o.slide_offset;
        var _cy2 = _cy1 + card_h;

        if (point_in_rectangle(_mx, _my, _cx1, _cy1, _cx2, _cy2)) {
            scr_autofill_tray(i);
            break;
        }
    }
*/
