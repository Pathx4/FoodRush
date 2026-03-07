/// ============================================================
/// OBJECT: obj_ui_hud
/// PARENT: none  |  DEPTH: -100  |  VISIBLE: true
/// Place in rm_game on layer "UI"
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    hud_h        = 64;           // height of HUD bar
    hearts_flash = 0;            // flash alpha when life lost
    score_display = 0;           // animated score counter
    timer_shake  = 0;            // shake when time is low
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    // Animate displayed score
    score_display = lerp(score_display, global.session_score, 0.12);

    // Flash decay
    if (hearts_flash > 0) hearts_flash -= 0.05;

    // Shake when < 15 seconds left
    if (global.time_left < 15 && global.time_left > 0) {
        timer_shake = sin(current_time * 0.03) * 2;
    } else {
        timer_shake = 0;
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  USER EVENT 0 — Force refresh                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    score_display = global.session_score;
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _W = display_get_gui_width();

    // ── Background panel ─────────────────────────────────
    draw_panel(0, 0, _W, hud_h, 0, COL_SURFACE, COL_BORDER, 1);

    // ── Level name ───────────────────────────────────────
    var _lv = global.level_data[global.session_level_id];
    draw_set_font(fnt_bold);
    draw_set_color(COL_ORANGE);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(12, hud_h * 0.5, _lv.name);

    // ── Score chip ───────────────────────────────────────
    var _sx = 200;
    draw_panel(_sx, 10, _sx + 130, hud_h - 10, 20, COL_SURFACE2, COL_BORDER, 1);
    draw_set_color(COL_TEXT2);
    draw_set_font(fnt_small);
    draw_text(_sx + 10, hud_h * 0.35, "SCORE");
    draw_set_color(COL_YELLOW);
    draw_set_font(fnt_bold_big);
    draw_text(_sx + 10, hud_h * 0.65, string(floor(score_display)));

    // ── Money chip ───────────────────────────────────────
    var _mx = 345;
    draw_panel(_mx, 10, _mx + 120, hud_h - 10, 20, COL_SURFACE2, COL_BORDER, 1);
    draw_set_color(COL_TEXT2);
    draw_set_font(fnt_small);
    draw_text(_mx + 10, hud_h * 0.35, "EARNED");
    draw_set_color(COL_GREEN);
    draw_set_font(fnt_bold_big);
    draw_text(_mx + 10, hud_h * 0.65, "$" + string(global.session_money));

    // ── Lives ────────────────────────────────────────────
    var _lx = 480;
    draw_panel(_lx, 10, _lx + 100, hud_h - 10, 20, COL_SURFACE2, COL_BORDER, 1);
    var _heart_col = (hearts_flash > 0) ? merge_color(COL_RED, c_white, hearts_flash) : COL_RED;
    draw_set_color(_heart_col);
    draw_set_font(fnt_bold_big);
    var _hearts_str = "";
    repeat (max(0, global.session_lives)) _hearts_str += "♥";
    if (global.session_lives <= 0) _hearts_str = "✖";
    draw_text(_lx + 10, hud_h * 0.5, _hearts_str);

    // ── Combo chip ───────────────────────────────────────
    var _cx = 595;
    draw_panel(_cx, 10, _cx + 90, hud_h - 10, 20, COL_SURFACE2, COL_BORDER, 1);
    draw_set_color(COL_TEXT2);
    draw_set_font(fnt_small);
    draw_text(_cx + 8, hud_h * 0.35, "COMBO");
    var _cmb_col = (global.session_combo >= 3) ? COL_ORANGE : COL_TEXT;
    draw_set_color(_cmb_col);
    draw_set_font(fnt_bold_big);
    draw_text(_cx + 8, hud_h * 0.65, "x" + string(max(1, global.session_combo)));

    // ── Timer bar ────────────────────────────────────────
    var _bar_x  = 700;
    var _bar_w  = _W - _bar_x - 120;
    var _pct    = global.time_left / global.level_data[global.session_level_id].duration;
    var _t_col  = (_pct > 0.5) ? COL_GREEN : (_pct > 0.2) ? COL_ORANGE : COL_RED;
    draw_progress_bar(_bar_x + timer_shake, 22, _bar_w, 12, _pct, COL_SURFACE2, _t_col, 6);

    draw_set_color(COL_TEXT2);
    draw_set_font(fnt_small);
    draw_set_halign(fa_center);
    draw_text(_bar_x + _bar_w * 0.5, 42, scr_format_time(ceil(global.time_left)));

    // ── Pause button ─────────────────────────────────────
    var _px = _W - 106;
    draw_panel(_px, 10, _px + 96, hud_h - 10, 12, COL_SURFACE2, COL_BORDER, 1);
    draw_set_color(COL_TEXT);
    draw_set_font(fnt_bold);
    draw_set_halign(fa_center);
    draw_text(_px + 48, hud_h * 0.5, "⏸ Pause");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT  (Pause button click)            ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _W  = display_get_gui_width();
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _px = _W - 106;

    if (point_in_rectangle(_mx, _my, _px, 10, _px + 96, hud_h - 10)) {
        if (global.game_state == GAME_STATE.PLAYING) {
            global.game_state = GAME_STATE.PAUSED;
            instance_activate_object(obj_ui_pause);
        }
        play_sound(SND_CLICK);
    }
*/
