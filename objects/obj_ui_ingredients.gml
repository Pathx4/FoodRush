/// ============================================================
/// OBJECT: obj_ui_ingredients
/// PARENT: none  |  DEPTH: -90  |  VISIBLE: true
/// Place in rm_game on layer "UI"
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    panel_x   = 8;
    panel_y   = 72;    // below HUD (hud_h = 64 + 8 margin)
    panel_w   = 420;
    panel_h   = display_get_gui_height() - panel_y - 8;

    btn_cols  = 4;
    btn_size  = 90;
    btn_pad   = 10;

    // Build button list from current level's available ingredients
    buttons = [];
    var _avail = global.level_data[global.session_level_id].ingredients;
    for (var i = 0; i < array_length(_avail); i++) {
        var _id  = _avail[i];
        var _ing = global.ing[_id];
        var _col = floor(i mod btn_cols);
        var _row = floor(i / btn_cols);
        array_push(buttons, {
            ing_id : _id,
            name   : _ing.name,
            spr    : _ing.spr,
            col    : _ing.col,
            bx     : panel_x + 8 + _col * (btn_size + btn_pad),
            by     : panel_y + 8 + _row * (btn_size + btn_pad),
            scale  : 1.0,   // for hover/press animation
            hover  : false,
        });
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (global.game_state != GAME_STATE.PLAYING) exit;

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    for (var i = 0; i < array_length(buttons); i++) {
        var _b  = buttons[i];
        var _in = point_in_rectangle(_mx, _my, _b.bx, _b.by, _b.bx + btn_size, _b.by + btn_size);
        _b.hover = _in;
        // Animate scale
        var _target_scale = _in ? 1.07 : 1.0;
        _b.scale = lerp(_b.scale, _target_scale, 0.2);
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    // Panel background
    draw_panel(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, 16, COL_BG, COL_BORDER, 1);

    // Section label
    draw_set_font(fnt_label);
    draw_set_color(COL_TEXT2);
    draw_set_halign(fa_left);
    draw_text(panel_x + 12, panel_y + 10, "🧺  INGREDIENTS");

    // Draw each ingredient button
    for (var i = 0; i < array_length(buttons); i++) {
        var _b   = buttons[i];
        var _bx2 = _b.bx + btn_size;
        var _by2 = _b.by + btn_size;
        var _cx  = (_b.bx + _bx2) * 0.5;
        var _cy  = (_b.by + _by2) * 0.5;

        // Check if this ingredient is in tray (highlight)
        var _in_tray = false;
        for (var t = 0; t < array_length(global.tray); t++) {
            if (global.tray[t] == _b.ing_id) { _in_tray = true; break; }
        }

        var _fill_col  = _in_tray ? merge_color(COL_SURFACE2, _b.col, 0.3) : COL_SURFACE;
        var _bord_col  = _in_tray ? _b.col : (_b.hover ? COL_ORANGE : COL_BORDER);

        // Scale pivot on center
        matrix_set(matrix_world, matrix_build(_cx, _cy, 0, 0, 0, 0, _b.scale, _b.scale, 1));

        // Draw button panel
        var _hw = (btn_size * _b.scale) * 0.5;
        draw_panel(-_hw, -_hw, _hw, _hw, 14, _fill_col, _bord_col, 1);

        // Draw ingredient sprite
        if (sprite_exists(_b.spr)) {
            draw_sprite_ext(_b.spr, 0, 0, -6, 1, 1, 0, c_white, 1);
        }

        // Ingredient name
        draw_set_font(fnt_tiny);
        draw_set_color(COL_TEXT2);
        draw_set_halign(fa_center);
        draw_text(0, 22, _b.name);

        matrix_set(matrix_world, matrix_build_identity());
    }

    draw_set_halign(fa_left);
*/

// ╔══════════════════════════════════════════════════════╗
// ║  LEFT PRESSED EVENT                                  ║
// ╚══════════════════════════════════════════════════════╝
/*
    if (global.game_state != GAME_STATE.PLAYING) exit;

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    for (var i = 0; i < array_length(buttons); i++) {
        var _b = buttons[i];
        if (point_in_rectangle(_mx, _my, _b.bx, _b.by, _b.bx + btn_size, _b.by + btn_size)) {
            // Add to tray
            array_push(global.tray, _b.ing_id);
            play_sound(SND_CLICK);

            // Press animation (quick scale down)
            _b.scale = 0.9;

            // Notify tray UI
            with (obj_ui_tray)   { event_user(0); }
            with (obj_ui_orders) { event_user(0); } // re-check matches
            break;
        }
    }
*/
