function draw_section_header(_cx, _y, _text, _col) {
    // Line ซ้าย
    draw_set_color(_col);
    draw_set_alpha(0.4);
    draw_line(_cx - 120, _y + 10, _cx - 60, _y + 10);
    // Line ขวา
    draw_line(_cx + 60,  _y + 10, _cx + 120, _y + 10);
    draw_set_alpha(1);

    draw_set_font(fnt_label);
    draw_set_color(_col);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_cx, _y, _text);
}