function scr_end_level() {
    global.game_state = GAME_STATE.RESULT;
    audio_stop_all();

    scr_unlock_next_level(global.session_level_id);

    // Signal obj_ui_result to show
    with (obj_ui_result) { event_user(0); }
}