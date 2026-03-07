/// @file scr_orders.gml
/// @desc All order management functions.

// ─────────────────────────────────────────────────────────────
// SPAWN ORDER
// ─────────────────────────────────────────────────────────────
function scr_spawn_order() {
    var _lv      = global.level_data[global.session_level_id];
    var _rec_id  = array_random(_lv.recipes);
    var _recipe  = global.recipe[_rec_id];

    // Pick random customer name + avatar index
    var _customer_names   = ["Alice","Bob","Chen","Diana","Eddie","Fiona","George","Hana","Ivan","Julia","Ken","Lily"];
    var _customer_avatars = [spr_avatar_0,spr_avatar_1,spr_avatar_2,spr_avatar_3,
                             spr_avatar_4,spr_avatar_5,spr_avatar_6,spr_avatar_7,
                             spr_avatar_8,spr_avatar_9,spr_avatar_10,spr_avatar_11];
    var _ci = irandom(array_length(_customer_names) - 1);

    // Tip amount based on recipe value
    var _tip = irandom_range(5, 30);

    var _order = {
        id          : ++global.order_id_counter,
        recipe_id   : _rec_id,
        recipe      : _recipe,
        customer    : _customer_names[_ci],
        avatar_spr  : _customer_avatars[_ci],
        time_limit  : _recipe.time_limit,
        time_left   : _recipe.time_limit,
        state       : ORDER_STATE.WAITING,
        tip         : _tip,
        created_at  : current_time,  // ms
        // UI slot position (set by obj_ui_orders)
        slot_y      : 0,
        slide_offset: 300,           // starts off-screen right
    };

    array_push(global.orders, _order);

    play_sound(SND_TICK);
}

// ─────────────────────────────────────────────────────────────
// TICK ORDERS  (call every step from obj_game_manager)
// ─────────────────────────────────────────────────────────────
function scr_tick_orders(_dt) {
    var _i = 0;
    repeat (array_length(global.orders)) {
        var _o = global.orders[_i];

        if (_o.state == ORDER_STATE.WAITING) {
            _o.time_left -= _dt;
            if (_o.time_left <= 0) {
                _o.time_left = 0;
                _o.state     = ORDER_STATE.EXPIRED;
                scr_order_expired(_i);
            }
        }

        // Animate slide-in
        if (_o.slide_offset > 0) {
            _o.slide_offset = lerp(_o.slide_offset, 0, 0.18);
            if (_o.slide_offset < 1) _o.slide_offset = 0;
        }

        _i++;
    }

    // Remove fully expired/served orders after a short delay
    // (handled by obj_ui_orders via removal flag)
}

// ─────────────────────────────────────────────────────────────
// ORDER EXPIRED
// ─────────────────────────────────────────────────────────────
function scr_order_expired(_index) {
    global.session_lives--;
    global.session_combo = 0;
    global.combo_timer   = 0;

    play_sound(SND_FAIL);

    // Flash the HUD hearts
    with (obj_ui_hud) { hearts_flash = 1.0; }

    // Spawn negative text
    scr_spawn_fx_text(WINDOW_W * 0.5, 120, "Order Expired! -1 Life", COL_RED);

    // Remove from array after brief delay — mark for removal
    global.orders[_index].state = ORDER_STATE.EXPIRED;

    // Check lives
    if (global.session_lives <= 0) {
        global.session_lives = 0;
        scr_end_level();
    }
}

// ─────────────────────────────────────────────────────────────
// SERVE DISH  (called when player hits Serve button)
// ─────────────────────────────────────────────────────────────
function scr_serve_dish() {
    // Find first WAITING order that matches the tray
    var _matched_index = -1;
    for (var i = 0; i < array_length(global.orders); i++) {
        var _o = global.orders[i];
        if (_o.state == ORDER_STATE.WAITING) {
            if (scr_tray_matches(global.tray, _o.recipe.ingredients)) {
                _matched_index = i;
                break;
            }
        }
    }

    if (_matched_index == -1) exit;  // no match

    var _o = global.orders[_matched_index];

    // ── Score calculation ────────────────────────────────
    var _elapsed    = (current_time - _o.created_at) / 1000.0;
    var _time_ratio = clamp((_o.recipe.time_limit - _elapsed) / _o.recipe.time_limit, 0, 1);
    var _time_bonus = floor(_time_ratio * 50);
    var _combo_mult = 1.0 + (global.session_combo * 0.25);
    var _base       = _o.recipe.points;
    var _earned     = floor(_base * _combo_mult) + _time_bonus;
    var _tip_earned = (_time_ratio > 0.5) ? _o.tip : 0;

    global.session_score  += _earned;
    global.session_money  += _base + _tip_earned;

    // ── Combo ────────────────────────────────────────────
    global.session_combo++;
    global.combo_timer = 8.0;  // seconds to keep combo alive

    // ── FX ───────────────────────────────────────────────
    play_sound(SND_SERVE);
    if (global.session_combo >= 3) play_sound(SND_COMBO);

    var _fx_col = (_earned > 200) ? COL_YELLOW : COL_GREEN;
    scr_spawn_fx_text(WINDOW_W * 0.45, 200, "+" + string(_earned), _fx_col);
    if (_tip_earned > 0) {
        scr_spawn_fx_text(WINDOW_W * 0.45, 240, "+$" + string(_tip_earned) + " tip!", COL_GREEN);
    }
    if (global.session_combo >= 3) {
        scr_spawn_fx_text(WINDOW_W * 0.45, 280, "COMBO x" + string(global.session_combo) + "!", COL_ORANGE);
    }

    // ── Mark order served ────────────────────────────────
    _o.state = ORDER_STATE.SERVED;

    // ── Clear tray ───────────────────────────────────────
    global.tray = [];

    // ── Notify UI ────────────────────────────────────────
    with (obj_ui_hud)     { event_user(0); }   // refresh HUD
    with (obj_ui_tray)    { event_user(0); }   // refresh tray
    with (obj_ui_orders)  { event_user(0); }   // refresh orders list
}

// ─────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────
function scr_orders_active_count() {
    var _c = 0;
    for (var i = 0; i < array_length(global.orders); i++) {
        if (global.orders[i].state == ORDER_STATE.WAITING) _c++;
    }
    return _c;
}

function scr_orders_cleanup() {
    // Remove served/expired orders that have finished their exit animation
    var _new = [];
    for (var i = 0; i < array_length(global.orders); i++) {
        if (global.orders[i].state == ORDER_STATE.WAITING) {
            array_push(_new, global.orders[i]);
        }
    }
    global.orders = _new;
}

// ─────────────────────────────────────────────────────────────
// AUTO-FILL TRAY FROM ORDER  (called when player clicks order)
// ─────────────────────────────────────────────────────────────
function scr_autofill_tray(_order_index) {
    var _o = global.orders[_order_index];
    if (_o.state != ORDER_STATE.WAITING) exit;

    global.tray = array_create(array_length(_o.recipe.ingredients));
    array_copy(global.tray, 0, _o.recipe.ingredients, 0, array_length(_o.recipe.ingredients));

    with (obj_ui_tray)   { event_user(0); }
    with (obj_ui_orders) { event_user(0); }
    play_sound(SND_CLICK);
}
