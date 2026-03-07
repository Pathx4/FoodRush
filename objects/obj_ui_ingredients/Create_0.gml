panel_x  = 8;
panel_y  = 88;       // ใต้ HUD (hud_h=80 + margin 8)
panel_w  = 430;

btn_size = 88;
btn_pad  = 8;
btn_cols = 4;

// สร้าง button list จาก level ปัจจุบัน
buttons = [];
var _avail = global.level_data[global.session_level_id].ingredients;
for (var i = 0; i < array_length(_avail); i++) {
    var _id  = _avail[i];
    var _ing = global.ing[_id];
    var _c   = i mod btn_cols;
    var _r   = floor(i / btn_cols);
    array_push(buttons, {
        ing_id : _id,
        name   : _ing.name,
        spr    : _ing.spr,
        col    : _ing.col,
        bx     : panel_x + 8 + _c * (btn_size + btn_pad),
        by     : panel_y + 8 + _r * (btn_size + btn_pad),
        hover  : false,
        scale  : 1.0,
    });
}

// คำนวณความสูง panel จากจำนวน row
var _rows = ceil(array_length(_avail) / btn_cols);
panel_h  = 8 + _rows * (btn_size + btn_pad) + 8;