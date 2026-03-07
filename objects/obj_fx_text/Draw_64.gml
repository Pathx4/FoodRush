    draw_set_font(fnt_fx);
    draw_set_color(fx_color);
    draw_set_alpha(alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Simple outline for readability
    draw_set_color(c_black);
    draw_text_transformed(x + 2, y + 2, fx_text, scale, scale, 0);
    draw_set_color(fx_color);
    draw_text_transformed(x, y, fx_text, scale, scale, 0);

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);