var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W * 0.5;

// BG
draw_set_color(COL_BG);
draw_rectangle(0, 0, _W, _H, false);

// Falling food sprites
for (var i = 0; i < array_length(floaties); i++) {
    var _f = floaties[i];
    if (_f.spr < 0 || !sprite_exists(_f.spr)) continue;
    var _sw = sprite_get_width(_f.spr);
    var _sh = sprite_get_height(_f.spr);
    draw_set_alpha(_f.alpha);
    draw_sprite_ext(_f.spr, 0,
        _f.x - _sw * 0.5 * _f.size,
        _f.y - _sh * 0.5 * _f.size,
        _f.size, _f.size,
        _f.rot, c_white, 1);
}
draw_set_alpha(1);

// Glow behind logo
draw_set_color(make_color_rgb(80, 30, 0));
draw_set_alpha(0.25 + sin(anim_timer * 0.05) * 0.08);
draw_ellipse(_cx - 280, logo_y - 60, _cx + 280, logo_y + 60, false);
draw_set_alpha(1);

// Subtitle
draw_set_font(fnt_label);
draw_set_color(COL_YELLOW);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_cx, logo_y - 52, "- A RESTAURANT MANAGEMENT GAME -");

// Logo shadow
draw_set_font(fnt_logo);
draw_set_color(make_color_rgb(120, 40, 0));
draw_set_alpha(0.3);
draw_text(_cx + 3, logo_y - 29 + logo_pulse, "FOOD RUSH");
draw_set_alpha(1);

// Logo main
draw_set_color(COL_ORANGE);
draw_text(_cx, logo_y - 32 + logo_pulse, "FOOD RUSH");

// Tagline
draw_set_font(fnt_bold);
draw_set_color(COL_TEXT2);
draw_text(_cx, logo_y + 80, "Cook fast.  Serve hot.  Earn big.");

draw_set_alpha(btn_alpha);

// Play button
var _by1    = _H * 0.55 + btn_y_off;
var _pb_c   = play_hover ? make_color_rgb(220,90,0) : COL_ORANGE;
var _pb_w   = play_hover ? 136 : 130;
draw_panel(_cx - _pb_w, _by1, _cx + _pb_w, _by1 + 52, 26, _pb_c, _pb_c, 1);
draw_set_font(fnt_bold_big);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _by1 + 26, "Play Game");

// How to Play button
var _hy1  = _by1 + 62;
var _hb_c = howto_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
var _hb_b = howto_hover ? COL_ORANGE : COL_BORDER;
draw_panel(_cx - 130, _hy1, _cx + 130, _hy1 + 52, 26, _hb_c, _hb_b, 1);
draw_set_font(fnt_bold_big);
draw_set_color(howto_hover ? COL_TEXT : COL_TEXT2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _hy1 + 26, "How to Play");

// Best score
var _best_total = 0;
for (var i = 0; i < LEVEL.COUNT; i++) {
    _best_total = max(_best_total, global.best_scores[i]);
}
draw_set_font(fnt_small);
draw_set_color(COL_TEXT2);
draw_set_valign(fa_top);
draw_text(_cx, _H * 0.88 + btn_y_off, "Best Score:");
draw_set_font(fnt_bold_big);
draw_set_color(COL_YELLOW);
draw_text(_cx, _H * 0.91 + btn_y_off, string(_best_total));

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);