visible     = true;
popup_scale = 0;
bg_alpha    = 0;
stars       = scr_get_stars(global.session_level_id, global.session_score);
stars_shown = 0;
star_timer  = 25;
star_scales = [0, 0, 0];
can_next    = (global.session_level_id + 1 < LEVEL.COUNT);

var _won = (global.session_score >= global.level_data[global.session_level_id].star_thresholds[0]
            || global.session_lives > 0);

if (stars == 3) {
    result_title = "Perfect Chef!";
    result_col   = COL_YELLOW;
    result_spr   = spr_result_perfect;
} else if (_won) {
    result_title = "Level Complete!";
    result_col   = COL_GREEN;
    result_spr   = spr_result_win;
} else {
    result_title = "Game Over!";
    result_col   = COL_RED;
    result_spr   = spr_result_lose;
}