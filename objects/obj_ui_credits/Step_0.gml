bg_alpha = lerp(bg_alpha, 0.75, 0.1);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

close_hover = point_in_rectangle(_mx, _my,
    panel_x + panel_w - 44, panel_y + 10,
    panel_x + panel_w - 10, panel_y + 44);

if (mouse_check_button_pressed(mb_left) && close_hover) instance_destroy();
if (keyboard_check_pressed(vk_escape)) instance_destroy();