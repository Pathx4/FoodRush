    logo_y      = -100;          // animate in from top
    logo_target = display_get_gui_height() * 0.3;
    btn_alpha   = 0;
    btn_y_off   = 30;
    play_hover  = false;
    howto_hover = false;

    // Floating food emojis
    food_emojis = ["🍔","🍕","🍜","🍣","🍗","🥗","🍱","🌮","🍝","🥘"];
    floaties = [];
    repeat (18) {
        array_push(floaties, {
            x     : random(display_get_gui_width()),
            y     : random(display_get_gui_height()),
            vy    : -(0.3 + random(0.8)),
            emoji : food_emojis[irandom(array_length(food_emojis) - 1)],
            size  : 0.6 + random(0.8),
            alpha : 0.08 + random(0.12),
            rot   : random(360),
            vrot  : (random(1) - 0.5) * 0.5,
        });
    }