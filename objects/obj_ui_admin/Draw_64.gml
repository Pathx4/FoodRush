var _px = panel_x;
var _py = panel_y;
var _cx = _px + panel_w * 0.5;

// Panel BG
draw_set_alpha(bg_alpha);
draw_panel(_px, _py, _px + panel_w, _py + panel_h,
           16, make_color_rgb(10, 5, 20), make_color_rgb(120, 60, 200), 1);
draw_set_alpha(1);

// ── Header ────────────────────────────────────────────
draw_set_color(make_color_rgb(30, 10, 60));
draw_roundrect_ext(_px, _py, _px + panel_w, _py + 46, 16, 16, false);
draw_set_color(make_color_rgb(30, 10, 60));
draw_rectangle(_px, _py + 26, _px + panel_w, _py + 46, false);
draw_set_color(make_color_rgb(120, 60, 200));
draw_line(_px, _py + 46, _px + panel_w, _py + 46);

draw_set_font(fnt_bold_big);
draw_set_color(make_color_rgb(200, 150, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx - 16, _py + 23, "ADMIN PANEL");

draw_set_font(fnt_tiny);
draw_set_color(make_color_rgb(150, 100, 200));
draw_text(_cx - 16, _py + 36, "F1 to close");

// Close button
var _xfill = hover_close ? make_color_rgb(180, 40, 40) : make_color_rgb(60, 20, 80);
draw_panel(_px + panel_w - 36, _py + 8, _px + panel_w - 8, _py + 36,
           6, _xfill, make_color_rgb(120, 60, 200), 1);
draw_set_font(fnt_bold);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_px + panel_w - 22, _py + 22, "X");

// ── Section: Freeze Time ──────────────────────────────
draw_set_font(fnt_tiny);
draw_set_color(make_color_rgb(150, 100, 200));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(_px + 14, _py + 48, "TIME CONTROL");

var _freeze_on   = global.admin_freeze;
var _fz_fill     = _freeze_on
    ? make_color_rgb(40, 20, 100)
    : (hover_freeze ? make_color_rgb(30, 15, 70) : make_color_rgb(20, 10, 45));
var _fz_bord     = _freeze_on
    ? make_color_rgb(120, 80, 255)
    : make_color_rgb(80, 40, 140);

draw_panel(_px + 12, _py + 58, _px + panel_w - 12, _py + 94,
           10, _fz_fill, _fz_bord, 1);

// Toggle indicator
var _tog_x = _px + 24;
var _tog_y = _py + 70;
draw_set_color(_freeze_on ? make_color_rgb(100, 60, 255) : make_color_rgb(60, 40, 100));
draw_roundrect_ext(_tog_x, _tog_y, _tog_x + 36, _tog_y + 16, 8, 8, false);
draw_set_color(c_white);
var _knob_x = _freeze_on ? _tog_x + 22 : _tog_x + 2;
draw_circle(_knob_x + 6, _tog_y + 8, 6, false);

draw_set_font(fnt_bold);
draw_set_color(_freeze_on ? make_color_rgb(180, 140, 255) : make_color_rgb(140, 100, 200));
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_tog_x + 44, _py + 76, _freeze_on ? "Time Frozen" : "Freeze Time");

// Status indicator
draw_set_font(fnt_tiny);
draw_set_color(_freeze_on ? make_color_rgb(100, 255, 150) : make_color_rgb(100, 100, 120));
draw_set_halign(fa_right);
draw_text(_px + panel_w - 20, _py + 70, _freeze_on ? "ON" : "OFF");

// ── Section: Speed ────────────────────────────────────
draw_set_font(fnt_tiny);
draw_set_color(make_color_rgb(150, 100, 200));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(_px + 14, _py + 102, "SPEED  " + (_freeze_on ? "(frozen)" : ""));

var _speeds   = [1.0, 2.0, 3.0];
var _sp_lbls  = ["1x", "2x", "3x"];
var _sp_hovs  = [hover_speed1, hover_speed2, hover_speed3];
var _sp_w     = (panel_w - 24 - 16) / 3;

for (var i = 0; i < 3; i++) {
    var _sx    = _px + 12 + i * (_sp_w + 8);
    var _active = (global.admin_speed == _speeds[i]) && !_freeze_on;
    var _sfill  = _active
        ? make_color_rgb(60, 20, 140)
        : (_sp_hovs[i] && !_freeze_on
            ? make_color_rgb(35, 15, 80)
            : make_color_rgb(20, 10, 45));
    var _sbord  = _active
        ? make_color_rgb(160, 100, 255)
        : make_color_rgb(60, 30, 100);

    draw_panel(_sx, _py + 112, _sx + _sp_w, _py + 146,
               8, _sfill, _sbord, 1);
    draw_set_font(_active ? fnt_bold_big : fnt_bold);
    draw_set_color(_active
        ? make_color_rgb(200, 160, 255)
        : (_freeze_on ? make_color_rgb(60, 40, 80) : make_color_rgb(140, 100, 180)));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_sx + _sp_w * 0.5, _py + 129, _sp_lbls[i]);
}

// ── Section: Auto-fill Ingredients ───────────────────
draw_set_font(fnt_tiny);
draw_set_color(make_color_rgb(150, 100, 200));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(_px + 14, _py + 154, "AUTO-FILL");

var _af_on   = global.admin_autofill;
var _af_fill = _af_on
    ? make_color_rgb(20, 60, 20)
    : (hover_autofill ? make_color_rgb(20, 35, 20) : make_color_rgb(10, 20, 10));
var _af_bord = _af_on
    ? make_color_rgb(60, 200, 80)
    : make_color_rgb(40, 100, 40);

draw_panel(_px + 12, _py + 164, _px + panel_w - 12, _py + 200,
           10, _af_fill, _af_bord, 1);

var _at_x = _px + 24;
var _at_y = _py + 176;
draw_set_color(_af_on ? make_color_rgb(40, 180, 60) : make_color_rgb(40, 80, 40));
draw_roundrect_ext(_at_x, _at_y, _at_x + 36, _at_y + 16, 8, 8, false);
draw_set_color(c_white);
var _ak_x = _af_on ? _at_x + 22 : _at_x + 2;
draw_circle(_ak_x + 6, _at_y + 8, 6, false);

draw_set_font(fnt_bold);
draw_set_color(_af_on ? make_color_rgb(100, 240, 120) : make_color_rgb(100, 160, 100));
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_at_x + 44, _py + 182, _af_on ? "Click order = auto-fill" : "Click order = auto-fill");

draw_set_font(fnt_tiny);
draw_set_color(_af_on ? make_color_rgb(100, 255, 150) : make_color_rgb(80, 100, 80));
draw_set_halign(fa_right);
draw_text(_px + panel_w - 20, _py + 176, _af_on ? "ON" : "OFF");

// ── Status bar ────────────────────────────────────────
draw_set_color(make_color_rgb(20, 10, 45));
draw_rectangle(_px, _py + panel_h - 40, _px + panel_w, _py + panel_h, false);
draw_set_color(make_color_rgb(80, 40, 140));
draw_line(_px, _py + panel_h - 40, _px + panel_w, _py + panel_h - 40);

var _status = "";
if (global.admin_freeze) {
    _status = "FROZEN TIME";
} else {
    _status = string(global.admin_speed) + "x speed";
}
if (global.admin_autofill) _status += "  |  Auto-fill";

draw_set_font(fnt_small);
draw_set_color(make_color_rgb(180, 140, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _py + panel_h - 20, _status);

draw_set_halign(fa_left);
draw_set_valign(fa_top);