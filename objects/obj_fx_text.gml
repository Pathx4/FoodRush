/// ============================================================
/// OBJECT: obj_fx_text
/// PARENT: none  |  DEPTH: -200  |  VISIBLE: true
/// Created dynamically via scr_spawn_fx_text()
/// ============================================================

// ╔══════════════════════════════════════════════════════╗
// ║  CREATE EVENT                                        ║
// ╚══════════════════════════════════════════════════════╝
/*
    fx_text  = "+0";
    fx_color = COL_GREEN;
    alpha    = 1.0;
    vy       = -2.5;             // upward drift speed
    lifetime = 70;               // steps before removal
    scale    = 0;                // animate in
    target_scale = 1.2;
*/

// ╔══════════════════════════════════════════════════════╗
// ║  STEP EVENT                                          ║
// ╚══════════════════════════════════════════════════════╝
/*
    lifetime--;
    y    += vy;
    vy   *= 0.95;                // decelerate
    scale = lerp(scale, target_scale, 0.25);

    if (lifetime < 25) {
        alpha -= 0.04;
    }
    if (lifetime <= 0 || alpha <= 0) {
        instance_destroy();
    }
*/

// ╔══════════════════════════════════════════════════════╗
// ║  DRAW GUI EVENT                                      ║
// ╚══════════════════════════════════════════════════════╝
/*
    draw_set_font(fnt_fx);
    draw_set_color(fx_color);
    draw_set_alpha(alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Simple outline for readability
    draw_set_color(c_black);
    draw_text_transformed(x + 2, y + 2, fx_text, scale, scale, 0);
    draw_set_color(fx_color);
    draw_text_transformed(x, y, fx_text, scale, scale, 0);

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
*/
