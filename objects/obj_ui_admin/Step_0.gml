bg_alpha = lerp(bg_alpha, 0.95, 0.15);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _px = panel_x;
var _py = panel_y;

// Close button
hover_close = point_in_rectangle(_mx, _my,
    _px + panel_w - 36, _py + 8,
    _px + panel_w - 8,  _py + 36);

// Freeze toggle
hover_freeze = point_in_rectangle(_mx, _my,
    _px + 12, _py + 56,
    _px + panel_w - 12, _py + 96);

// Speed buttons
hover_speed1 = point_in_rectangle(_mx, _my,
    _px + 12, _py + 110,
    _px + 88, _py + 148);
hover_speed2 = point_in_rectangle(_mx, _my,
    _px + 96, _py + 110,
    _px + 172, _py + 148);
hover_speed3 = point_in_rectangle(_mx, _my,
    _px + 180, _py + 110,
    _px + panel_w - 12, _py + 148);

// Autofill toggle
hover_autofill = point_in_rectangle(_mx, _my,
    _px + 12, _py + 162,
    _px + panel_w - 12, _py + 202);

// Apply freeze — override delta_time effect via global flag
// (obj_ui_hud จะเช็ค global.admin_freeze ก่อน _dt)

if (mouse_check_button_pressed(mb_left)) {
    if (hover_close) {
        instance_destroy();
        exit;
    }
    if (hover_freeze) {
        global.admin_freeze = !global.admin_freeze;
        // ถ้า freeze ให้ speed กลับเป็น 1x ก่อน
        if (global.admin_freeze) global.admin_speed = 1.0;
    }
    if (!global.admin_freeze) {
        if (hover_speed1) global.admin_speed = 1.0;
        if (hover_speed2) global.admin_speed = 2.0;
        if (hover_speed3) global.admin_speed = 3.0;
    }
    if (hover_autofill) {
        global.admin_autofill = !global.admin_autofill;
    }
}

if (keyboard_check_pressed(vk_f1)) {
    instance_destroy();
    exit;
}