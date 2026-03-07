/// ============================================================
/// OBJECT: obj_game_manager
/// PARENT: none  |  PERSISTENT: true  |  VISIBLE: false
/// Place ONE instance in rm_title.
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    scr_data_init();
    scr_load();

    // Session variables (reset each game)
    global.session_score    = 0;
    global.session_money    = 0;
    global.session_lives    = 3;
    global.session_combo    = 0;
    global.session_level_id = LEVEL.STREET_STALL;

    // Tray (ingredient slots player has assembled)
    global.tray = [];           // array of ING enums

    // Orders list (array of order structs)
    global.orders = [];

    // Game state
    global.game_state  = GAME_STATE.PLAYING;
    global.time_left   = 0;
    global.order_timer = 0;     // countdown to next spawn
    global.order_id_counter = 0;

    // Combo timeout
    global.combo_timer = 0;

    // Difficulty scaling (increases as score goes up)
    global.difficulty = 1.0;

    audio_play_sound(SND_BGM_TITLE, 1, true);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
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
*/

// ╔══════════════════════════════════════════════════════╗
// ║  HELPER: scr_start_level(_level_id)                 ║
// ╚══════════════════════════════════════════════════════╝
function scr_start_level(_level_id) {
    var _lv = global.level_data[_level_id];

    global.session_score    = 0;
    global.session_money    = 0;
    global.session_lives    = 3;
    global.session_combo    = 0;
    global.session_level_id = _level_id;
    global.tray             = [];
    global.orders           = [];
    global.order_id_counter = 0;
    global.time_left        = _lv.duration;
    global.order_timer      = 2;   // first order after 2s
    global.combo_timer      = 0;
    global.difficulty       = 1.0;
    global.game_state       = GAME_STATE.PLAYING;

    audio_stop_all();
    audio_play_sound(SND_BGM_GAME, 1, true);

    room_goto(rm_game);
}

// ╔══════════════════════════════════════════════════════╗
// ║  HELPER: scr_end_level()                            ║
// ╚══════════════════════════════════════════════════════╝
function scr_end_level() {
    global.game_state = GAME_STATE.RESULT;
    audio_stop_all();

    scr_unlock_next_level(global.session_level_id);

    // Signal obj_ui_result to show
    with (obj_ui_result) { event_user(0); }
}
