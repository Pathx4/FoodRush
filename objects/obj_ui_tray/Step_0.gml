if (global.game_state != GAME_STATE.PLAYING) exit;

// คำนวณ panel_y จาก obj_ui_ingredients
if (instance_exists(obj_ui_ingredients)) {
    panel_y = obj_ui_ingredients.panel_y + obj_ui_ingredients.panel_h + 8;
}

// คำนวณความสูง panel
var _tray_rows = max(1, ceil(array_length(global.tray) / 6));
var _tray_h    = 16 + _tray_rows * (tray_item_size + tray_item_gap) + 8;
var _btn_h     = 44;
var _panel_h   = 26 + _tray_h + _btn_h + 12;

// Serve / Clear button bounds
var _serve_bx = panel_x + 8;
var _serve_by = panel_y + _panel_h - _btn_h - 8;
var _serve_bw = panel_w - 90;
var _clear_bx = _serve_bx + _serve_bw + 8;
var _clear_bw = panel_w - _serve_bw - 24;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

serve_hover = point_in_rectangle(_mx, _my, _serve_bx, _serve_by, _serve_bx + _serve_bw, _serve_by + _btn_h);
clear_hover = point_in_rectangle(_mx, _my, _clear_bx, _serve_by, _clear_bx + _clear_bw, _serve_by + _btn_h);

var _can_serve = (matched_recipe_id != -1);
serve_scale = lerp(serve_scale, (serve_hover && _can_serve) ? 1.04 : 1.0, 0.2);

if (mouse_check_button_pressed(mb_left)) {
    // Serve
    if (serve_hover && _can_serve) {
        serve_scale = 0.93;
        scr_serve_dish();
        event_user(0);
        return;
    }

    // Clear
    if (clear_hover) {
        global.tray       = [];
        matched_recipe_id = -1;
        play_sound(SND_CLICK);
        with (obj_ui_orders) { event_user(0); }
        return;
    }

    // คลิก tray item เพื่อลบออก
    var _items_start_y = panel_y + 26;
    for (var i = 0; i < array_length(global.tray); i++) {
        var _ix = panel_x + 8 + i * (tray_item_size + tray_item_gap);
        var _iy = _items_start_y;
        if (point_in_rectangle(_mx, _my, _ix, _iy, _ix + tray_item_size, _iy + tray_item_size)) {
            array_delete(global.tray, i, 1);
            event_user(0);
            with (obj_ui_orders) { event_user(0); }
            play_sound(SND_CLICK);
            break;
        }
    }
}