card_cols  = 3;
card_w     = 240;
card_h     = 190;
card_gap_x = 20;
card_gap_y = 20;
grid_x     = (display_get_gui_width()  - (card_cols * card_w + (card_cols - 1) * card_gap_x)) * 0.5;
grid_y     = 120;

hover_card  = -1;
card_scales = array_create(LEVEL.COUNT, 0.97);