depth     = -500;
bg_alpha  = 0;
close_hover = false;

// Scroll
scroll_y     = 0;
scroll_target = 0;
content_h    = 620;   // ความสูงเนื้อหาทั้งหมด

// Panel
var _W = display_get_gui_width();
var _H = display_get_gui_height();
panel_w = min(520, _W - 80);
panel_h = min(560, _H - 80);
panel_x = _W * 0.5 - panel_w * 0.5;
panel_y = _H * 0.5 - panel_h * 0.5;