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
    draw_text(_cx, logo_y - 50, "- A RESTAURANT MANAGEMENT GAME -");

    // Main logo
    draw_set_font(fnt_logo);
    draw_set_color(COL_ORANGE);
    draw_text(_cx, logo_y - 35 ,"FOOD RUSH");

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
    draw_text(_cx, _by1 + 26, "Play Game");

    // How to Play button
    var _hy1  = _by1 + 62;
    var _hb_c = howto_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
    var _hb_b = howto_hover ? COL_ORANGE : COL_BORDER;
    draw_panel(_cx - 130, _hy1, _cx + 130, _hy1 + 52, 26, _hb_c, _hb_b, 1);
    draw_set_color(howto_hover ? COL_TEXT : COL_TEXT2);
    draw_text(_cx, _hy1 + 26, "How to Play");

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