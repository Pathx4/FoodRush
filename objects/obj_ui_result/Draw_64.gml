	if (!visible) exit;

	var _W  = display_get_gui_width();
	var _H  = display_get_gui_height();
	var _cx = _W * 0.5;
	var _cy = _H * 0.5;

	// Dim BG
	draw_set_color(c_black);
	draw_set_alpha(bg_alpha);
	draw_rectangle(0, 0, _W, _H, false);
	draw_set_alpha(1);

	if (popup_scale < 0.05) exit;

	var _pw = 360;
	var _ph = 380;
	var _px = _cx - _pw * 0.5;
	var _py = _cy - _ph * 0.5;

	// Popup panel
	draw_panel(_px, _py, _px + _pw, _py + _ph, 24, COL_SURFACE, COL_BORDER, 1);

	// ── Row 1: Icon กึ่งกลาง ──────────────────────────────
	var _icon_y = _py + 20;
	if (sprite_exists(result_spr)) {
	    draw_sprite_ext(result_spr, 0,
	        _cx - 32 , _icon_y - 5,
	        popup_scale, popup_scale,
	        0, c_white, 1);
	}

	// ── Row 2: Title กึ่งกลาง ─────────────────────────────
	var _title_y = _icon_y + 64;
	draw_set_font(fnt_title);
	draw_set_color(result_col);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(_cx, _title_y, result_title);

	// ── Row 3: Stars กึ่งกลาง ────────────────────────────
	var _star_y   = _title_y + 48;
	var _star_gap = 58;

	for (var i = 0; i < 3; i++) {
	    var _ss = star_scales[i];
	    var _sx = _cx - _star_gap + (i-0.5) * _star_gap;
	    draw_set_alpha((i < stars) ? 1.0 : 0.25);
	    if (sprite_exists(spr_star_on)) {
	        var _spr = (i < stars_shown) ? spr_star_on : spr_star_off;
	        draw_sprite_ext(_spr, 0, _sx, _star_y,
	                        _ss * 1.2, _ss * 1.2, 0, c_white, 1);
	    } else {
	        // fallback สี่เหลี่ยมแทน star
	        draw_set_color((i < stars) ? COL_YELLOW : COL_SURFACE2);
	        draw_roundrect_ext(_sx - 16, _star_y - 16, _sx + 16, _star_y + 16, 4, 4, false);
	    }
	}
	draw_set_alpha(1);

	// ── Row 4: Stat boxes ────────────────────────────────
	var _stat_y = _star_y + 50;
	var _sw3    = (_pw - 48) / 3;

	// SCORE
	draw_panel(_px + 16,              _stat_y,
	           _px + 16 + _sw3,       _stat_y + 68,
	           10, COL_SURFACE2, COL_BORDER, 1);
	draw_set_font(fnt_tiny);
	draw_set_color(COL_TEXT2);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(_px + 16 + _sw3 * 0.5, _stat_y + 10, "SCORE");
	draw_set_font(fnt_bold_big);
	draw_set_color(COL_YELLOW);
	draw_text(_px + 16 + _sw3 * 0.5, _stat_y + 32, string(global.session_score));

	// EARNED
	draw_panel(_px + 24 + _sw3,       _stat_y,
	           _px + 24 + _sw3 * 2,   _stat_y + 68,
	           10, COL_SURFACE2, COL_BORDER, 1);
	draw_set_font(fnt_tiny);
	draw_set_color(COL_TEXT2);
	draw_text(_px + 24 + _sw3 * 1.5, _stat_y + 10, "EARNED");
	draw_set_font(fnt_bold_big);
	draw_set_color(COL_GREEN);
	draw_text(_px + 24 + _sw3 * 1.5, _stat_y + 32, "$" + string(global.session_money));

	// LIVES
	draw_panel(_px + 32 + _sw3 * 2,   _stat_y,
	           _px + _pw - 16,         _stat_y + 68,
	           10, COL_SURFACE2, COL_BORDER, 1);
	draw_set_font(fnt_tiny);
	draw_set_color(COL_TEXT2);
	draw_text(_px + 32 + _sw3 * 2.5, _stat_y + 10, "LIVES");
	draw_set_font(fnt_bold_big);
	draw_set_color(COL_RED);
	draw_text(_px + 32 + _sw3 * 2.5, _stat_y + 32, string(max(0, global.session_lives)));

	// ── Row 5: Retry + Next Level ────────────────────────
	var _btn_y  = _py + _ph - 120;
	var _btn_h  = 44;
	var _half_w = (_pw - 48) * 0.5;

	// Retry
	var _r_fill = retry_hover ? make_color_rgb(220,80,0) : COL_ORANGE;
	draw_panel(_px + 16,           _btn_y,
	           _px + 16 + _half_w, _btn_y + _btn_h,
	           12, _r_fill, _r_fill, 1);
	draw_set_font(fnt_bold_big);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_px + 16 + _half_w * 0.5, _btn_y + _btn_h * 0.5, "Retry");

	// Next Level
	if (can_next) {
	    var _n_fill = next_hover ? make_color_rgb(40,180,45) : COL_GREEN;
	    draw_panel(_px + 24 + _half_w,       _btn_y,
	               _px + 24 + _half_w * 2,   _btn_y + _btn_h,
	               12, _n_fill, _n_fill, 1);
	    draw_set_font(fnt_bold_big);
	    draw_set_color(c_white);
	    draw_set_halign(fa_center);
	    draw_set_valign(fa_middle);
	    draw_text(_px + 24 + _half_w * 1.5, _btn_y + _btn_h * 0.5, "Next Level");
	}

	// ── Row 6: Level Select ───────────────────────────────
	var _menu_y  = _py + _ph - 56;
	var _m_fill  = menu_hover ? COL_SURFACE2 : make_color_rgb(35,18,0);
	var _m_bord  = menu_hover ? COL_ORANGE : COL_BORDER;
	draw_panel(_px + 16,      _menu_y,
	           _px + _pw - 16, _menu_y + 36,
	           12, _m_fill, _m_bord, 1);
	draw_set_font(fnt_bold);
	draw_set_color(menu_hover ? COL_TEXT : COL_TEXT2);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_cx, _menu_y + 18, "Level Select");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
