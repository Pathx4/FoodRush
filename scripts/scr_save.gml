/// @file scr_save.gml
/// @desc Save and load player progress using ini file.

// ─── SAVE ────────────────────────────────────────────────────
function scr_save() {
    ini_open("foodrush_save.ini");

    // Best scores per level
    for (var i = 0; i < LEVEL.COUNT; i++) {
        ini_write_real("scores", "level_" + string(i), global.best_scores[i]);
    }

    // Unlocked levels
    for (var i = 0; i < LEVEL.COUNT; i++) {
        ini_write_real("progress", "unlocked_" + string(i), global.unlocked[i]);
    }

    ini_close();
}

// ─── LOAD ────────────────────────────────────────────────────
function scr_load() {
    global.best_scores = array_create(LEVEL.COUNT, 0);
    global.unlocked    = array_create(LEVEL.COUNT, false);
    global.unlocked[0] = true; // Level 1 always unlocked

    ini_open("foodrush_save.ini");

    for (var i = 0; i < LEVEL.COUNT; i++) {
        global.best_scores[i] = ini_read_real("scores",   "level_" + string(i), 0);
        global.unlocked[i]    = bool(ini_read_real("progress", "unlocked_" + string(i), i == 0 ? 1 : 0));
    }

    ini_close();
}

// ─── UNLOCK NEXT LEVEL ───────────────────────────────────────
function scr_unlock_next_level(_level_id) {
    var _next = _level_id + 1;
    if (_next < LEVEL.COUNT) {
        global.unlocked[_next] = true;
    }
    if (global.session_score > global.best_scores[_level_id]) {
        global.best_scores[_level_id] = global.session_score;
    }
    scr_save();
}

// ─── GET STAR RATING ─────────────────────────────────────────
function scr_get_stars(_level_id, _score) {
    var _thresh = global.level_data[_level_id].star_thresholds;
    if (_score >= _thresh[2]) return 3;
    if (_score >= _thresh[1]) return 2;
    if (_score >= _thresh[0]) return 1;
    return 0;
}
