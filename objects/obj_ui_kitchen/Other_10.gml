serve_flash      = 1.0;
combo_display    = global.session_combo;
combo_show_timer = 90;

// หาชื่อ recipe ล่าสุด
serve_msg = "";
for (var i = array_length(global.orders) - 1; i >= 0; i--) {
    if (global.orders[i].state == ORDER_STATE.SERVED) {
        serve_msg       = "+" + string(global.orders[i].recipe.points) + "  " + global.orders[i].recipe.name;
        serve_msg_timer = 120;
        break;
    }
}