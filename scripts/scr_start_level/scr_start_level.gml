function scr_start_level(_level_id) {
    var _lv = global.level_data[_level_id];

    global.session_score    = 0;
    global.session_money    = 0;
    global.session_lives    = 3;
    global.session_combo    = 0;
    global.session_served   = 0;   // ← นับจำนวนจานที่ serve ได้
    global.session_level_id = _level_id;
    global.tray             = [];
    global.orders           = [];
    global.order_id_counter = 0;
    global.time_left        = _lv.duration;
    global.order_timer      = 2;
    global.combo_timer      = 0;
    global.difficulty       = 1.0;
    global.game_state       = GAME_STATE.PLAYING;

    audio_stop_all();
    audio_play_sound(SND_BGM_GAME, 1, true);
    room_goto(rm_game);
}


