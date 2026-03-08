anim_timer  = 0;
back_hover  = false;
card_scales = [];
card_y_off  = [];
card_hover  = [];

for (var i = 0; i < LEVEL.COUNT; i++) {
    array_push(card_scales, 0.0);  // animate in from 0
    array_push(card_y_off,  30.0); // slide in from below
    array_push(card_hover,  false);
}

// Floating particles (subtle)
particles = [];
var _W = display_get_gui_width();
var _H = display_get_gui_height();
for (var i = 0; i < 10; i++) {
    array_push(particles, {
        x     : random(_W),
        y     : random(_H),
        size  : 2 + random(3),
        vy    : -0.3 - random(0.4),
        alpha : 0.06 + random(0.1),
        col   : choose(COL_ORANGE, COL_YELLOW, COL_GREEN),
    });
}
