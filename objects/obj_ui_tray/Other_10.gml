matched_recipe_id = -1;
for (var i = 0; i < array_length(global.orders); i++) {
    var _o = global.orders[i];
    if (_o.state == ORDER_STATE.WAITING) {
        if (scr_tray_matches(global.tray, _o.recipe.ingredients)) {
            matched_recipe_id = _o.recipe_id;
            break;
        }
    }
}