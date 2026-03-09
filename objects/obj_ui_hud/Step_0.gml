if (room != rm_game) exit;

// ── คำนวณ _dt พร้อม admin override ก่อนทุกอย่าง ─────
var _dt = delta_time / 1000000;
if (variable_global_exists("admin_freeze") && global.admin_freeze) {
    _dt = 0;
} else if (variable_global_exists("admin_speed")) {
    _dt *= global.admin_speed;
}

// ── Game logic (เฉพาะตอน PLAYING) ───────────────────
if (global.game_state == GAME_STATE.PLAYING) {
    score_display = lerp(score_display, global.session_score, 0.12);
    if (hearts_flash > 0) hearts_flash -= 0.05;
    if (global.time_left < 15 && global.time_left > 0) {
        timer_shake = sin(current_time * 0.03) * 2;
    } else {
        timer_shake = 0;
    }

    // Timer
    global.time_left -= _dt;
    if (global.time_left <= 0) {
        global.time_left = 0;
        scr_end_level();
    }

    // Order spawner
    global.order_timer -= _dt;
    if (global.order_timer <= 0) {
        var _lv = global.level_data[global.session_level_id];
        if (scr_orders_active_count() < _lv.max_orders) {
            scr_spawn_order();
        }
        global.order_timer = max(3, _lv.order_interval / global.difficulty);
    }

    // Combo decay
    if (global.session_combo > 0) {
        global.combo_timer -= _dt;
        if (global.combo_timer <= 0) {
            global.session_combo = 0;
            global.combo_timer   = 0;
        }
    }

    // Tick orders
    scr_tick_orders(_dt);

    // Difficulty
    global.difficulty = 1.0 + (global.session_score / 3000.0);
}

// ── Pause button ──────────────────────────────────────
var _W  = display_get_gui_width();
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
pause_hover = point_in_rectangle(_mx, _my, _W - 110, 14, _W - 10, hud_h - 14);
if (mouse_check_button_pressed(mb_left) && pause_hover) {
    if (global.game_state == GAME_STATE.PLAYING) {
        instance_create_layer(0, 0, "Instances", obj_ui_pause);
    }
}

// ── F1 toggle admin panel ─────────────────────────────
if (keyboard_check_pressed(vk_f1)) {
    if (instance_exists(obj_ui_admin)) {
        instance_destroy(obj_ui_admin);
    } else {
        instance_create_layer(0, 0, "Instances", obj_ui_admin);
    }
}