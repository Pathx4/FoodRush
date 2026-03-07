/// @file scr_constants.gml
/// @desc Global constants and macros for Food Rush

// ─── GAME SETTINGS ───────────────────────────────────────────
#macro GAME_VERSION      "1.0.0"
#macro WINDOW_W          1280
#macro WINDOW_H          720

// ─── LAYERS ──────────────────────────────────────────────────
#macro LAYER_BG          "Background"
#macro LAYER_WORLD       "World"
#macro LAYER_UI          "UI"
#macro LAYER_FX          "FX"

// ─── ROOMS ───────────────────────────────────────────────────
// rm_title, rm_level_select, rm_game, rm_result  (defined in GMS2 editor)

// ─── COLORS ──────────────────────────────────────────────────
#macro COL_ORANGE        make_color_rgb(255, 107,   0)
#macro COL_YELLOW        make_color_rgb(255, 184,   0)
#macro COL_GREEN         make_color_rgb( 76, 175,  80)
#macro COL_RED           make_color_rgb(244,  67,  54)
#macro COL_BLUE          make_color_rgb( 33, 150, 243)
#macro COL_PURPLE        make_color_rgb(156,  39, 176)
#macro COL_BG            make_color_rgb( 26,  10,   0)
#macro COL_SURFACE       make_color_rgb( 45,  21,   0)
#macro COL_SURFACE2      make_color_rgb( 61,  32,  16)
#macro COL_BORDER        make_color_rgb( 90,  58,  32)
#macro COL_TEXT          make_color_rgb(255, 248, 240)
#macro COL_TEXT2         make_color_rgb(200, 168, 130)

// ─── ORDER STATES ────────────────────────────────────────────
enum ORDER_STATE {
    WAITING,
    MATCHED,
    SERVED,
    EXPIRED
}

// ─── INGREDIENT IDs ──────────────────────────────────────────
enum ING {
    BUN,
    PATTY,
    CHEESE,
    LETTUCE,
    TOMATO,
    ONION,
    RICE,
    NOODLE,
    EGG,
    SHRIMP,
    CHICKEN,
    FISH,
    SAUCE,
    VEGGIE,
    BREAD,
    DOUGH,
    COUNT   // total number of ingredients
}

// ─── RECIPE IDs ──────────────────────────────────────────────
enum RECIPE {
    BURGER,
    CHEESEBURGER,
    RICE_EGG,
    FRIED_RICE,
    NOODLE_SOUP,
    SHRIMP_RICE,
    FISH_CHIPS,
    CHICKEN_RICE,
    PIZZA,
    SANDWICH,
    SUSHI,
    RAMEN,
    COUNT
}

// ─── LEVEL IDs ───────────────────────────────────────────────
enum LEVEL {
    STREET_STALL,
    FOOD_TRUCK,
    NOODLE_HOUSE,
    SUSHI_BAR,
    PIZZA_PALACE,
    GRAND_RESTAURANT,
    COUNT
}

// ─── GAME STATES ─────────────────────────────────────────────
enum GAME_STATE {
    PLAYING,
    PAUSED,
    ENDING,
    RESULT
}

// ─── ANIMATION CONSTANTS ─────────────────────────────────────
#macro ANIM_SPEED_FAST   0.15
#macro ANIM_SPEED_MED    0.08
#macro ANIM_SPEED_SLOW   0.04

// ─── AUDIO (set your actual sound asset names here) ──────────
#macro SND_CLICK         snd_click
#macro SND_SERVE         snd_serve
#macro SND_FAIL          snd_fail
#macro SND_COMBO         snd_combo
#macro SND_TICK          snd_tick
#macro SND_BGM_TITLE     snd_bgm_title
#macro SND_BGM_GAME      snd_bgm_game
