/// @file scr_utils.gml
/// @desc Utility functions used across the project.

// ─── ARRAY SORT (ingredient IDs) ─────────────────────────────
/// Returns a sorted copy of an array of integers
function array_sort_copy(_arr) {
    var _copy = array_create(array_length(_arr));
    array_copy(_copy, 0, _arr, 0, array_length(_arr));
    // Bubble sort (arrays are small, <= 6 elements)
    var _n = array_length(_copy);
    for (var i = 0; i < _n - 1; i++) {
        for (var j = 0; j < _n - i - 1; j++) {
            if (_copy[j] > _copy[j+1]) {
                var _tmp   = _copy[j];
                _copy[j]   = _copy[j+1];
                _copy[j+1] = _tmp;
            }
        }
    }
    return _copy;
}

// ─── TRAY MATCH ──────────────────────────────────────────────
/// Returns true if _tray (array of ING enums) matches _recipe_ingredients
function scr_tray_matches(_tray, _recipe_ingredients) {
    if (array_length(_tray) != array_length(_recipe_ingredients)) return false;
    var _a = array_sort_copy(_tray);
    var _b = array_sort_copy(_recipe_ingredients);
    for (var i = 0; i < array_length(_a); i++) {
        if (_a[i] != _b[i]) return false;
    }
    return true;
}

// ─── FORMAT TIME ─────────────────────────────────────────────
/// Returns "1:45" format string from seconds
function scr_format_time(_secs) {
    var _m = floor(_secs / 60);
    var _s = _secs mod 60;
    return string(_m) + ":" + string_format(_s, 2, 0);
}

// ─── LERP COLOR ──────────────────────────────────────────────
/// Lerp between two BGR colors (GML uses BGR)
function lerp_color(_c1, _c2, _t) {
    return merge_color(_c1, _c2, _t);
}

// ─── EASE OUT QUART ──────────────────────────────────────────
function ease_out_quart(_t) {
    return 1 - power(1 - _t, 4);
}

// ─── EASE OUT BACK ───────────────────────────────────────────
function ease_out_back(_t) {
    var c1 = 1.70158;
    var c3 = c1 + 1;
    return 1 + c3 * power(_t - 1, 3) + c1 * power(_t - 1, 2);
}

// ─── DRAW ROUNDED RECT ───────────────────────────────────────
/// Draw a filled rounded rectangle
function draw_roundrect_color_custom(_x1, _y1, _x2, _y2, _r, _col, _alpha) {
    draw_set_color(_col);
    draw_set_alpha(_alpha);
    draw_roundrect_ext(_x1, _y1, _x2, _y2, _r, _r, false);
    draw_set_alpha(1);
}

// ─── DRAW PANEL ──────────────────────────────────────────────
/// Draw a standard UI panel with border
function draw_panel(_x1, _y1, _x2, _y2, _radius, _fill_col, _border_col, _alpha) {
    draw_set_alpha(_alpha);
    // Fill
    draw_set_color(_fill_col);
    draw_roundrect_ext(_x1, _y1, _x2, _y2, _radius, _radius, false);
    // Border
    draw_set_color(_border_col);
    draw_roundrect_ext(_x1, _y1, _x2, _y2, _radius, _radius, true);
    draw_set_alpha(1);
}

// ─── DRAW PROGRESS BAR ───────────────────────────────────────
/// Draw a horizontal progress bar
function draw_progress_bar(_x, _y, _w, _h, _pct, _col_bg, _col_fill, _radius) {
    // BG
    draw_set_color(_col_bg);
    draw_roundrect_ext(_x, _y, _x + _w, _y + _h, _radius, _radius, false);
    // Fill (clamp)
    var _fw = max(0, _w * clamp(_pct, 0, 1));
    if (_fw > 0) {
        draw_set_color(_col_fill);
        draw_roundrect_ext(_x, _y, _x + _fw, _y + _h, _radius, _radius, false);
    }
}

// ─── SPAWN FX TEXT ───────────────────────────────────────────
/// Spawn a floating score text particle at world position
function scr_spawn_fx_text(_x, _y, _text, _col) {
    var _inst = instance_create_layer(_x, _y, LAYER_FX, obj_fx_text);
    _inst.fx_text  = _text;
    _inst.fx_color = _col;
}

// ─── RANDOM FROM ARRAY ───────────────────────────────────────
function array_random(_arr) {
    return _arr[irandom(array_length(_arr) - 1)];
}

// ─── PLAY SOUND SAFE ─────────────────────────────────────────
/// Play a sound only if it exists (avoids crash in dev)
function play_sound(_snd) {
    if (audio_exists(_snd)) audio_play_sound(_snd, 1, false);
}
