logo_y      = display_get_gui_height() * 0.38;
btn_alpha   = 0;
btn_y_off   = 40;
play_hover  = false;
howto_hover = false;
anim_timer  = 0;
logo_pulse  = 0;

// Instance variable — ใช้ได้ทุก event
ing_sprs = [];
var _spr_names = [
    "spr_ing_bun",  "spr_ing_beef",    "spr_ing_cheese", "spr_ing_lettuce",
    "spr_ing_tomato","spr_ing_rice",   "spr_ing_egg",    "spr_ing_chicken",
    "spr_ing_sauce", "spr_ing_onion",  "spr_ing_noodle", "spr_ing_shrimp",
];
for (var i = 0; i < array_length(_spr_names); i++) {
    var _id = asset_get_index(_spr_names[i]);
    if (_id >= 0) array_push(ing_sprs, _id);
}
if (array_length(ing_sprs) == 0) array_push(ing_sprs, -1);

// Falling food particles
floaties = [];
var _W = display_get_gui_width();
var _H = display_get_gui_height();
for (var i = 0; i < 18; i++) {
    var _spr = ing_sprs[irandom(array_length(ing_sprs) - 1)];
    array_push(floaties, {
        x       : random(_W),
        y       : random(_H),
        spr     : _spr,
        size    : 0.5 + random(0.7),
        rot     : random(360),
        rot_s   : (random(2) - 1) * 0.6,
        vy      : 0.4 + random(0.8),
        alpha   : 0.08 + random(0.12),
        wobble  : random(6.28),
        wobble_s: 0.02 + random(0.02),
    });
}