/// ============================================================
/// OBJECT: obj_title_screen
/// Place ONE instance in rm_title  |  DEPTH: -100
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    logo_y      = -100;          // animate in from top
    logo_target = display_get_gui_height() * 0.3;
    btn_alpha   = 0;
    btn_y_off   = 30;
    play_hover  = false;
    howto_hover = false;

    // Floating food emojis
    food_emojis = ["🍔","🍕","🍜","🍣","🍗","🥗","🍱","🌮","🍝","🥘"];
    floaties = [];
    repeat (18) {
        array_push(floaties, {
            x     : random(display_get_gui_width()),
            y     : random(display_get_gui_height()),
            vy    : -(0.3 + random(0.8)),
            emoji : food_emojis[irandom(array_length(food_emojis) - 1)],
            size  : 0.6 + random(0.8),
            alpha : 0.08 + random(0.12),
            rot   : random(360),
            vrot  : (random(1) - 0.5) * 0.5,
        });
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    logo_y    = lerp(logo_y,    logo_target, 0.08);
    btn_alpha = lerp(btn_alpha, 1.0,         0.04);
    btn_y_off = lerp(btn_y_off, 0,           0.07);

    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    play_hover  = point_in_rectangle(_mx, _my, _cx - 130, _H * 0.55 + btn_y_off, _cx + 130, _H * 0.55 + btn_y_off + 52);
    howto_hover = point_in_rectangle(_mx, _my, _cx - 130, _H * 0.55 + btn_y_off + 62, _cx + 130, _H * 0.55 + btn_y_off + 114);

    // Animate floaties
    for (var i = 0; i < array_length(floaties); i++) {
        var _f = floaties[i];
        _f.y   += _f.vy;
        _f.rot += _f.vrot;
        if (_f.y < -60) {
            _f.y = _H + 30;
            _f.x = random(_W);
        }
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();
    var _cx = _W * 0.5;

    // BG gradient (draw solid BG color first in room)
    draw_set_color(COL_BG);
    draw_rectangle(0, 0, _W, _H, false);

    // Floating food
    draw_set_font(fnt_emoji_large);
    draw_set_halign(fa_center);
    for (var i = 0; i < array_length(floaties); i++) {
        var _f = floaties[i];
        draw_set_alpha(_f.alpha);
        draw_text_transformed(_f.x, _f.y, _f.emoji, _f.size, _f.size, _f.rot);
    }
    draw_set_alpha(1);

    // Subtitle
    draw_set_font(fnt_label);
    draw_set_color(COL_YELLOW);
    draw_text(_cx, logo_y - 50, "⭐  A RESTAURANT MANAGEMENT GAME  ⭐");

    // Main logo
    draw_set_font(fnt_logo);
    draw_set_color(COL_ORANGE);
    draw_text(_cx, logo_y, "FOOD RUSH");

    // Tagline
    draw_set_font(fnt_bold);
    draw_set_color(COL_TEXT2);
    draw_text(_cx, logo_y + 80, "Cook fast.  Serve hot.  Earn big.");

    draw_set_alpha(btn_alpha);

    // Play button
    var _by1  = _H * 0.55 + btn_y_off;
    var _pb_c = play_hover ? make_color_rgb(220,90,0) : COL_ORANGE;
    draw_panel(_cx - 130, _by1, _cx + 130, _by1 + 52, 26, _pb_c, _pb_c, 1);
    draw_set_font(fnt_bold_big);
    draw_set_color(c_white);
    draw_set_valign(fa_middle);
    draw_text(_cx, _by1 + 26, "🍽️  Play Game");

    // How to Play button
    var _hy1  = _by1 + 62;
    var _hb_c = howto_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
    var _hb_b = howto_hover ? COL_ORANGE : COL_BORDER;
    draw_panel(_cx - 130, _hy1, _cx + 130, _hy1 + 52, 26, _hb_c, _hb_b, 1);
    draw_set_color(howto_hover ? COL_TEXT : COL_TEXT2);
    draw_text(_cx, _hy1 + 26, "📖  How to Play");

    // Best score
    var _best_total = 0;
    for (var i = 0; i < LEVEL.COUNT; i++) _best_total = max(_best_total, global.best_scores[i]);
    draw_set_font(fnt_small);
    draw_set_color(COL_TEXT2);
    draw_text(_cx, _H * 0.88 + btn_y_off, "Best Score:");
    draw_set_font(fnt_bold_big);
    draw_set_color(COL_YELLOW);
    draw_text(_cx, _H * 0.91 + btn_y_off, string(_best_total));

    draw_set_alpha(1);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT                                  ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (play_hover) {
        play_sound(SND_CLICK);
        room_goto(rm_level_select);
    }
    if (howto_hover) {
        play_sound(SND_CLICK);
        instance_create_layer(0, 0, LAYER_UI, obj_ui_how_to_play);
    }
*/


/// ============================================================
/// OBJECT: obj_level_select
/// Place ONE instance in rm_level_select  |  DEPTH: -100
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    card_cols  = 3;
    card_w     = 240;
    card_h     = 200;
    card_gap_x = 20;
    card_gap_y = 20;
    grid_x     = (display_get_gui_width()  - (card_cols * card_w + (card_cols-1) * card_gap_x)) * 0.5;
    grid_y     = 130;

    hover_card = -1;
    card_scales = array_create(LEVEL.COUNT, 0.95);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    hover_card = -1;

    for (var i = 0; i < LEVEL.COUNT; i++) {
        var _col  = i mod card_cols;
        var _row  = floor(i / card_cols);
        var _cx   = grid_x + _col * (card_w + card_gap_x);
        var _cy   = grid_y + _row * (card_h + card_gap_y);
        var _hover = global.unlocked[i] && point_in_rectangle(_mx, _my, _cx, _cy, _cx + card_w, _cy + card_h);
        if (_hover) hover_card = i;
        var _ts = _hover ? 1.0 : 0.97;
        card_scales[i] = lerp(card_scales[i], _ts, 0.2);
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _W  = display_get_gui_width();
    var _H  = display_get_gui_height();

    draw_set_color(COL_BG);
    draw_rectangle(0, 0, _W, _H, false);

    // Header
    draw_set_font(fnt_title);
    draw_set_color(COL_ORANGE);
    draw_set_halign(fa_center);
    draw_text(_W * 0.5, 20, "🗺️  Choose a Level");
    draw_set_font(fnt_small);
    draw_set_color(COL_TEXT2);
    draw_text(_W * 0.5, 72, "Select your restaurant challenge");

    // Level cards
    for (var i = 0; i < LEVEL.COUNT; i++) {
        var _lv   = global.level_data[i];
        var _col  = i mod card_cols;
        var _row  = floor(i / card_cols);
        var _bx   = grid_x + _col * (card_w + card_gap_x);
        var _by   = grid_y + _row * (card_h + card_gap_y);
        var _sc   = card_scales[i];
        var _lock = !global.unlocked[i];
        var _best = global.best_scores[i];
        var _stars= scr_get_stars(i, _best);

        // Scale pivot on center
        var _ccx  = _bx + card_w * 0.5;
        var _ccy  = _by + card_h * 0.5;
        var _hw   = card_w * _sc * 0.5;
        var _hh   = card_h * _sc * 0.5;

        matrix_set(matrix_world, matrix_build(_ccx, _ccy, 0, 0, 0, 0, _sc, _sc, 1));

        var _fill = _lock ? COL_SURFACE : (hover_card == i ? COL_SURFACE2 : COL_SURFACE);
        var _bord = _lock ? COL_BORDER  : (hover_card == i ? COL_ORANGE : COL_BORDER);
        draw_panel(-_hw, -_hh, _hw, _hh, 20, _fill, _bord, _lock ? 0.5 : 1.0);

        draw_set_halign(fa_center);

        // Level icon sprite
        if (sprite_exists(_lv.icon)) {
            draw_sprite_ext(_lv.icon, 0, 0, -50, 1, 1, 0, c_white, _lock ? 0.4 : 1.0);
        }

        draw_set_font(fnt_bold_big);
        draw_set_color(_lock ? COL_TEXT2 : COL_TEXT);
        draw_text(0, -10, _lv.name);

        draw_set_font(fnt_small);
        draw_set_color(COL_TEXT2);
        draw_text_ext(0, 15, "", -1, card_w - 30);

        // Stars
        for (var s = 0; s < 3; s++) {
            var _sa = (s < _stars) ? 1.0 : 0.2;
            draw_set_alpha(_sa);
            draw_set_font(fnt_emoji);
            draw_text(-32 + s * 32, 50, "⭐");
        }
        draw_set_alpha(1);

        if (_lock) {
            draw_set_font(fnt_bold);
            draw_set_color(COL_BORDER);
            draw_text(0, 75, "🔒 Locked");
        } else if (_best > 0) {
            draw_set_font(fnt_tiny);
            draw_set_color(COL_TEXT2);
            draw_text(0, 75, "Best: " + string(_best));
        }

        matrix_set(matrix_world, matrix_build_identity());
    }

    // Back button
    draw_panel(20, _H - 55, 130, _H - 15, 14, COL_SURFACE2, COL_BORDER, 1);
    draw_set_font(fnt_bold);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_center);
    draw_text(75, _H - 35, "← Back");

    draw_set_halign(fa_left);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT                                  ║
// ╚══════════════════════════════════════════════════════╝
/*
    var _H  = display_get_gui_height();
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Back button
    if (point_in_rectangle(_mx, _my, 20, _H - 55, 130, _H - 15)) {
        play_sound(SND_CLICK);
        room_goto(rm_title);
        return;
    }

    // Level cards
    if (hover_card >= 0 && global.unlocked[hover_card]) {
        play_sound(SND_CLICK);
        scr_start_level(hover_card);
    }
*/
