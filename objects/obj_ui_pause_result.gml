/// ============================================================
/// OBJECT: obj_ui_pause
/// PARENT: none  |  DEPTH: -300  |  VISIBLE: true
/// Activated/deactivated by obj_ui_hud
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    popup_scale  = 0;
    bg_alpha     = 0;
    btn_resume_y = 0;
    btn_quit_y   = 0;
    resume_hover = false;
    quit_hover   = false;

    // Pause the game
    global.game_state = GAME_STATE.PAUSED;
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    popup_scale = lerp(popup_scale, 1.0, 0.2);
    bg_alpha    = lerp(bg_alpha, 0.7, 0.15);

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;
    var _cy = _H * 0.5;
    var _pw = 380;
    var _ph = 260;

    resume_hover = point_in_rectangle(_mx, _my, _cx - 120, _cy + 20, _cx + 120, _cy + 65);
    quit_hover   = point_in_rectangle(_mx, _my, _cx - 120, _cy + 75, _cx + 120, _cy + 120);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;
    var _cy = _H * 0.5;

    // Dim overlay
    draw_set_color(c_black);
    draw_set_alpha(bg_alpha);
    draw_rectangle(0, 0, _W, _H, false);
    draw_set_alpha(1);

    // Popup panel
    var _pw = 380 * popup_scale;
    var _ph = 260 * popup_scale;
    draw_panel(_cx - _pw * 0.5, _cy - _ph * 0.5, _cx + _pw * 0.5, _cy + _ph * 0.5, 24, COL_SURFACE, COL_BORDER, 1);

    // Icon & title
    draw_set_font(fnt_emoji_large);
    draw_set_halign(fa_center);
    draw_text(_cx, _cy - 100, "⏸️");
    draw_set_font(fnt_title);
    draw_set_color(COL_TEXT);
    draw_text(_cx, _cy - 55, "Paused");
    draw_set_font(fnt_small);
    draw_set_color(COL_TEXT2);
    draw_text(_cx, _cy - 20, "Your orders are waiting!");

    // Resume button
    var _rb_col = resume_hover ? make_color_rgb(60,200,65) : COL_GREEN;
    draw_panel(_cx - 120, _cy + 20, _cx + 120, _cy + 65, 14, _rb_col, _rb_col, 1);
    draw_set_font(fnt_bold);
    draw_set_color(c_white);
    draw_text(_cx, _cy + 43, "▶  Resume");

    // Quit button
    var _qb_col  = quit_hover ? COL_RED : COL_SURFACE2;
    var _qb_bord = quit_hover ? COL_RED : COL_BORDER;
    draw_panel(_cx - 120, _cy + 75, _cx + 120, _cy + 120, 14, _qb_col, _qb_bord, 1);
    draw_set_color(quit_hover ? c_white : COL_TEXT2);
    draw_text(_cx, _cy + 98, "🏠  Quit to Menu");

    draw_set_halign(fa_left);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT                                  ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (resume_hover) {
        global.game_state = GAME_STATE.PLAYING;
        instance_destroy();
        return;
    }
    if (quit_hover) {
        global.game_state = GAME_STATE.PLAYING; // reset before leaving
        room_goto(rm_title);
        instance_destroy();
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  KEY PRESSED — ESCAPE                                ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (keyboard_check_pressed(vk_escape)) {
        global.game_state = GAME_STATE.PLAYING;
        instance_destroy();
    }
*/


/// ============================================================
/// OBJECT: obj_ui_result
/// PARENT: none  |  DEPTH: -300  |  VISIBLE: true
/// Activated at end of level via User Event 0
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    visible      = false;
    popup_scale  = 0;
    bg_alpha     = 0;
    stars_shown  = 0;         // animate stars one by one
    star_timer   = 30;        // steps between each star
    star_scales  = [0, 0, 0];

    retry_hover  = false;
    next_hover   = false;
    menu_hover   = false;

    stars        = 0;
    can_next     = false;
*/

// ╔══════════════════════════════════════════════════════╗
// ║  USER EVENT 0 — Show result screen                   ║
// ╚══════════════════════════════════════════════════════╝
/*
    visible     = true;
    popup_scale = 0;
    bg_alpha    = 0;
    stars       = scr_get_stars(global.session_level_id, global.session_score);
    stars_shown = 0;
    star_timer  = 25;
    star_scales = [0, 0, 0];
    can_next    = (global.session_level_id + 1 < LEVEL.COUNT);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (!visible) exit;

    popup_scale = lerp(popup_scale, 1.0, 0.15);
    bg_alpha    = lerp(bg_alpha,    0.75, 0.1);

    // Animate stars sequentially
    star_timer--;
    if (star_timer <= 0 && stars_shown < stars) {
        stars_shown++;
        star_timer = 22;
    }
    for (var i = 0; i < 3; i++) {
        var _target = (i < stars_shown) ? 1.0 : 0.0;
        star_scales[i] = lerp(star_scales[i], _target, 0.22);
    }

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;
    var _cy = _H * 0.5;

    retry_hover = point_in_rectangle(_mx, _my, _cx - 140, _cy + 110, _cx - 10, _cy + 155);
    next_hover  = can_next && point_in_rectangle(_mx, _my, _cx + 10, _cy + 110, _cx + 140, _cy + 155);
    menu_hover  = point_in_rectangle(_mx, _my, _cx - 130, _cy + 165, _cx + 130, _cy + 200);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (!visible) exit;

    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;
    var _cy = _H * 0.5;

    // Dim overlay
    draw_set_color(c_black);
    draw_set_alpha(bg_alpha);
    draw_rectangle(0, 0, _W, _H, false);
    draw_set_alpha(1);

    // Popup
    var _pw = 460 * popup_scale;
    var _ph = 360 * popup_scale;
    draw_panel(_cx - _pw * 0.5, _cy - _ph * 0.5, _cx + _pw * 0.5, _cy + _ph * 0.5, 28, COL_SURFACE, COL_BORDER, 1);

    if (popup_scale < 0.2) exit;

    // Title
    var _won  = global.session_score >= global.level_data[global.session_level_id].star_thresholds[0];
    var _icon = _won ? (stars == 3 ? "🏆" : "🎉") : "😢";
    var _title= _won ? (stars == 3 ? "Perfect Chef!" : "Level Complete!") : "Game Over!";

    draw_set_font(fnt_emoji_large);
    draw_set_halign(fa_center);
    draw_text(_cx, _cy - 155, _icon);

    draw_set_font(fnt_title);
    draw_set_color(COL_TEXT);
    draw_text(_cx, _cy - 110, _title);

    // Stars
    var _star_size = 48;
    for (var i = 0; i < 3; i++) {
        var _sx    = _cx - 72 + i * 72;
        var _ss    = star_scales[i];
        var _alpha = (i < stars) ? 1.0 : 0.2;
        draw_set_alpha(_alpha);
        draw_set_font(fnt_star);
        draw_set_halign(fa_center);
        draw_text_transformed(_sx, _cy - 60, "⭐", _ss * 1.5, _ss * 1.5, 0);
    }
    draw_set_alpha(1);

    // Stats row
    var _stats = [
        { icon:"⭐", val:string(global.session_score), lbl:"Score"      },
        { icon:"💰", val:"$"+string(global.session_money), lbl:"Earned" },
        { icon:"❤️", val:string(max(0,global.session_lives)), lbl:"Lives"},
    ];
    for (var i = 0; i < 3; i++) {
        var _sx = _cx - 120 + i * 120;
        draw_set_font(fnt_emoji);
        draw_text(_sx, _cy + 0, _stats[i].icon);
        draw_set_font(fnt_title);
        draw_set_color(COL_YELLOW);
        draw_text(_sx, _cy + 22, _stats[i].val);
        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT2);
        draw_text(_sx, _cy + 50, _stats[i].lbl);
    }

    // Retry button
    var _rc = retry_hover ? make_color_rgb(220,80,0) : COL_ORANGE;
    draw_panel(_cx - 140, _cy + 110, _cx - 10, _cy + 155, 14, _rc, _rc, 1);
    draw_set_font(fnt_bold);
    draw_set_color(c_white);
    draw_text(_cx - 75, _cy + 133, "🔄 Retry");

    // Next Level button
    if (can_next) {
        var _nc = next_hover ? make_color_rgb(56,200,60) : COL_GREEN;
        draw_panel(_cx + 10, _cy + 110, _cx + 140, _cy + 155, 14, _nc, _nc, 1);
        draw_text(_cx + 75, _cy + 133, "➡️ Next");
    }

    // Menu button
    var _mc  = menu_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
    var _mbc = menu_hover ? COL_ORANGE : COL_BORDER;
    draw_panel(_cx - 130, _cy + 165, _cx + 130, _cy + 200, 14, _mc, _mbc, 1);
    draw_set_color(menu_hover ? COL_TEXT : COL_TEXT2);
    draw_text(_cx, _cy + 183, "📋 Level Select");

    draw_set_halign(fa_left);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT                                  ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (!visible) exit;

    if (retry_hover) {
        scr_start_level(global.session_level_id);
        instance_destroy();
        return;
    }
    if (can_next && next_hover) {
        scr_start_level(global.session_level_id + 1);
        instance_destroy();
        return;
    }
    if (menu_hover) {
        room_goto(rm_level_select);
        instance_destroy();
    }
*/
