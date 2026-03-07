    // Only run game logic when in rm_game
    if (room != rm_game) exit;
    if (global.game_state != GAME_STATE.PLAYING) exit;

    var _dt = delta_time / 1000000; // seconds

    // ── Timer countdown ──────────────────────────────────
    global.time_left -= _dt;
    if (global.time_left <= 0) {
        global.time_left = 0;
        scr_end_level();
        exit;
    }

    // ── Order spawner ────────────────────────────────────
    global.order_timer -= _dt;
    if (global.order_timer <= 0) {
        var _lv     = global.level_data[global.session_level_id];
        var _active = scr_orders_active_count();
        if (_active < _lv.max_orders) {
            scr_spawn_order();
        }
        // Next spawn interval scales with difficulty
        global.order_timer = max(3, _lv.order_interval / global.difficulty);
    }

    // ── Combo decay ──────────────────────────────────────
    if (global.session_combo > 0) {
        global.combo_timer -= _dt;
        if (global.combo_timer <= 0) {
            global.session_combo = 0;
            global.combo_timer   = 0;
        }
    }

    // ── Order age ────────────────────────────────────────
    scr_tick_orders(_dt);

    // ── Difficulty scale ─────────────────────────────────
    global.difficulty = 1.0 + (global.session_score / 3000.0);