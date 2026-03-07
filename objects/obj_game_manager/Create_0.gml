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