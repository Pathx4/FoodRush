depth       = -600;
bg_alpha    = 0;
panel_w     = 320;
panel_h     = 360;

var _W = display_get_gui_width();
var _H = display_get_gui_height();
panel_x = _W - panel_w - 16;
panel_y = 88;

// Hover states
hover_freeze    = false;
hover_speed1    = false;
hover_speed2    = false;
hover_speed3    = false;
hover_autofill  = false;
hover_close     = false;

// ── Global admin flags (ตั้งถ้ายังไม่มี) ─────────────
if (!variable_global_exists("admin_enabled"))   global.admin_enabled   = true;
if (!variable_global_exists("admin_freeze"))    global.admin_freeze    = false;
if (!variable_global_exists("admin_speed"))     global.admin_speed     = 1.0;
if (!variable_global_exists("admin_autofill"))  global.admin_autofill  = false;
