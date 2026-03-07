draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h,
           14, COL_BG, COL_BORDER, 1);

// Section label
draw_set_font(fnt_label);
draw_set_color(COL_TEXT2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(panel_x + 10, panel_y + 600, "INGREDIENTS");

for (var i = 0; i < array_length(buttons); i++) {
    var _b   = buttons[i];
    var _bcx = _b.bx + btn_size * 0.5;  // center x ของปุ่ม
    var _bcy = _b.by + btn_size * 0.5;  // center y ของปุ่ม
    var _hw  = btn_size * _b.scale * 0.5;

    // เช็คว่า ingredient นี้อยู่ใน tray ไหม
    var _in_tray = false;
    for (var t = 0; t < array_length(global.tray); t++) {
        if (global.tray[t] == _b.ing_id) { _in_tray = true; break; }
    }

    // สีปุ่ม
    var _fill = _in_tray ? merge_color(COL_SURFACE2, _b.col, 0.25) : COL_SURFACE;
    var _bord = _in_tray ? _b.col : (_b.hover ? COL_ORANGE : COL_BORDER);

    // วาด panel (จาก center)
    draw_panel(_bcx - _hw, _bcy - _hw, _bcx + _hw, _bcy + _hw, 12, _fill, _bord, 1);

    // วาด sprite ตรงกลางปุ่ม
    if (sprite_exists(_b.spr)) {
        // ตั้ง origin sprite ให้อยู่กึ่งกลางก่อนใช้งาน
       var _sw = sprite_get_width(_b.spr);
	   var _sh = sprite_get_height(_b.spr);
	   draw_sprite_ext(_b.spr, 0,
		_bcx - _sw * 0.5 * (_b.scale * 0.72),
		_bcy - 8 - _sh * 0.5 * (_b.scale * 0.72),
		_b.scale * 0.72,
		_b.scale * 0.72,
		0, c_white, 1);
    }

    // ชื่อ ingredient
    draw_set_font(fnt_tiny);
    draw_set_color(_in_tray ? COL_TEXT : COL_TEXT2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_bcx, _bcy + 26, _b.name);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);