bg_alpha = lerp(bg_alpha, 0.75, 0.1);

var _wheel = mouse_wheel_down() - mouse_wheel_up();
scroll_target += _wheel * 28;
var _max_scroll = max(0, content_h - panel_h + 80);
scroll_target = clamp(scroll_target, 0, _max_scroll);
scroll_y = lerp(scroll_y, scroll_target, 0.18);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

close_hover = point_in_rectangle(_mx, _my,
    panel_x + panel_w - 44, panel_y + 10,
    panel_x + panel_w - 10, panel_y + 44);

if (mouse_check_button_pressed(mb_left) && close_hover) instance_destroy();
if (keyboard_check_pressed(vk_escape)) instance_destroy();