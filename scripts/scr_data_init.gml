/// @file scr_data_init.gml
/// @desc Initialize all static game data into global arrays/structs.
///       Call once from obj_game_manager Create event.

function scr_data_init() {

    // ─────────────────────────────────────────────────────────
    // INGREDIENTS
    // global.ing[ING.xxx] = { name, sprite, color }
    // ─────────────────────────────────────────────────────────
    global.ing = array_create(ING.COUNT);

    global.ing[ING.BUN]     = { name:"Bun",     spr:spr_ing_bun,     col:make_color_rgb(255,152, 0) };
    global.ing[ING.PATTY]   = { name:"Patty",   spr:spr_ing_patty,   col:make_color_rgb(183, 28,28) };
    global.ing[ING.CHEESE]  = { name:"Cheese",  spr:spr_ing_cheese,  col:make_color_rgb(255,193,  7) };
    global.ing[ING.LETTUCE] = { name:"Lettuce", spr:spr_ing_lettuce, col:make_color_rgb( 67,160, 71) };
    global.ing[ING.TOMATO]  = { name:"Tomato",  spr:spr_ing_tomato,  col:make_color_rgb(229, 57, 53) };
    global.ing[ING.ONION]   = { name:"Onion",   spr:spr_ing_onion,   col:make_color_rgb(142, 36,170) };
    global.ing[ING.RICE]    = { name:"Rice",    spr:spr_ing_rice,    col:make_color_rgb(238,238,238) };
    global.ing[ING.NOODLE]  = { name:"Noodle",  spr:spr_ing_noodle,  col:make_color_rgb(255,152,  0) };
    global.ing[ING.EGG]     = { name:"Egg",     spr:spr_ing_egg,     col:make_color_rgb(255,249,196) };
    global.ing[ING.SHRIMP]  = { name:"Shrimp",  spr:spr_ing_shrimp,  col:make_color_rgb(255,112, 67) };
    global.ing[ING.CHICKEN] = { name:"Chicken", spr:spr_ing_chicken, col:make_color_rgb(255,179,  0) };
    global.ing[ING.FISH]    = { name:"Fish",    spr:spr_ing_fish,    col:make_color_rgb( 33,150,243) };
    global.ing[ING.SAUCE]   = { name:"Sauce",   spr:spr_ing_sauce,   col:make_color_rgb(121, 85, 72) };
    global.ing[ING.VEGGIE]  = { name:"Veggie",  spr:spr_ing_veggie,  col:make_color_rgb(102,187,106) };
    global.ing[ING.BREAD]   = { name:"Bread",   spr:spr_ing_bread,   col:make_color_rgb(215,168, 96) };
    global.ing[ING.DOUGH]   = { name:"Dough",   spr:spr_ing_dough,   col:make_color_rgb(245,245,245) };

    // ─────────────────────────────────────────────────────────
    // RECIPES
    // global.recipe[RECIPE.xxx] = { name, spr_dish, ingredients[], points, time_limit }
    // ─────────────────────────────────────────────────────────
    global.recipe = array_create(RECIPE.COUNT);

    global.recipe[RECIPE.BURGER]       = { name:"Classic Burger",  spr:spr_dish_burger,       ingredients:[ING.BUN,ING.PATTY,ING.LETTUCE,ING.TOMATO],          points:100, time_limit:25 };
    global.recipe[RECIPE.CHEESEBURGER] = { name:"Cheeseburger",    spr:spr_dish_cheeseburger, ingredients:[ING.BUN,ING.PATTY,ING.CHEESE,ING.LETTUCE],           points:130, time_limit:28 };
    global.recipe[RECIPE.RICE_EGG]     = { name:"Egg on Rice",     spr:spr_dish_rice_egg,     ingredients:[ING.RICE,ING.EGG,ING.SAUCE],                         points:80,  time_limit:20 };
    global.recipe[RECIPE.FRIED_RICE]   = { name:"Fried Rice",      spr:spr_dish_fried_rice,   ingredients:[ING.RICE,ING.EGG,ING.ONION,ING.SAUCE],               points:110, time_limit:25 };
    global.recipe[RECIPE.NOODLE_SOUP]  = { name:"Noodle Soup",     spr:spr_dish_noodle_soup,  ingredients:[ING.NOODLE,ING.SHRIMP,ING.VEGGIE,ING.SAUCE],         points:150, time_limit:30 };
    global.recipe[RECIPE.SHRIMP_RICE]  = { name:"Shrimp Rice",     spr:spr_dish_shrimp_rice,  ingredients:[ING.RICE,ING.SHRIMP,ING.VEGGIE],                     points:120, time_limit:22 };
    global.recipe[RECIPE.FISH_CHIPS]   = { name:"Fish & Chips",    spr:spr_dish_fish_chips,   ingredients:[ING.FISH,ING.BREAD,ING.VEGGIE],                      points:110, time_limit:24 };
    global.recipe[RECIPE.CHICKEN_RICE] = { name:"Chicken Rice",    spr:spr_dish_chicken_rice, ingredients:[ING.RICE,ING.CHICKEN,ING.SAUCE],                     points:120, time_limit:23 };
    global.recipe[RECIPE.PIZZA]        = { name:"Mini Pizza",      spr:spr_dish_pizza,        ingredients:[ING.DOUGH,ING.CHEESE,ING.TOMATO,ING.VEGGIE],         points:160, time_limit:35 };
    global.recipe[RECIPE.SANDWICH]     = { name:"Club Sandwich",   spr:spr_dish_sandwich,     ingredients:[ING.BREAD,ING.CHICKEN,ING.LETTUCE,ING.TOMATO],       points:140, time_limit:28 };
    global.recipe[RECIPE.SUSHI]        = { name:"Sushi Roll",      spr:spr_dish_sushi,        ingredients:[ING.RICE,ING.FISH,ING.EGG],                          points:170, time_limit:28 };
    global.recipe[RECIPE.RAMEN]        = { name:"Ramen Bowl",      spr:spr_dish_ramen,        ingredients:[ING.NOODLE,ING.EGG,ING.CHICKEN,ING.ONION],           points:180, time_limit:35 };

    // ─────────────────────────────────────────────────────────
    // LEVELS
    // global.level_data[LEVEL.xxx] = struct
    // ─────────────────────────────────────────────────────────
    global.level_data = array_create(LEVEL.COUNT);

    global.level_data[LEVEL.STREET_STALL] = {
        name            : "Street Stall",
        icon            : spr_level_stall,
        duration        : 90,
        max_orders      : 4,
        order_interval  : 12,   // seconds between spawns
        recipes         : [RECIPE.BURGER, RECIPE.RICE_EGG, RECIPE.FRIED_RICE, RECIPE.CHICKEN_RICE],
        ingredients     : [ING.BUN, ING.PATTY, ING.LETTUCE, ING.TOMATO, ING.RICE, ING.EGG, ING.CHICKEN, ING.SAUCE],
        star_thresholds : [300, 500, 750],
        goal_score      : 500
    };

    global.level_data[LEVEL.FOOD_TRUCK] = {
        name            : "Food Truck",
        icon            : spr_level_truck,
        duration        : 100,
        max_orders      : 5,
        order_interval  : 10,
        recipes         : [RECIPE.BURGER, RECIPE.CHEESEBURGER, RECIPE.RICE_EGG, RECIPE.FRIED_RICE, RECIPE.FISH_CHIPS, RECIPE.CHICKEN_RICE],
        ingredients     : [ING.BUN, ING.PATTY, ING.CHEESE, ING.LETTUCE, ING.TOMATO, ING.RICE, ING.EGG, ING.FISH, ING.CHICKEN, ING.SAUCE, ING.BREAD, ING.VEGGIE],
        star_thresholds : [500, 800, 1200],
        goal_score      : 800
    };

    global.level_data[LEVEL.NOODLE_HOUSE] = {
        name            : "Noodle House",
        icon            : spr_level_noodle,
        duration        : 110,
        max_orders      : 6,
        order_interval  : 9,
        recipes         : [RECIPE.NOODLE_SOUP, RECIPE.SHRIMP_RICE, RECIPE.FRIED_RICE, RECIPE.RAMEN, RECIPE.SANDWICH, RECIPE.SUSHI],
        ingredients     : [ING.RICE, ING.NOODLE, ING.EGG, ING.SHRIMP, ING.CHICKEN, ING.FISH, ING.ONION, ING.SAUCE, ING.VEGGIE, ING.LETTUCE, ING.BREAD],
        star_thresholds : [700, 1000, 1500],
        goal_score      : 1000
    };

    global.level_data[LEVEL.SUSHI_BAR] = {
        name            : "Sushi Bar",
        icon            : spr_level_sushi,
        duration        : 100,
        max_orders      : 6,
        order_interval  : 8,
        recipes         : [RECIPE.SUSHI, RECIPE.SHRIMP_RICE, RECIPE.FISH_CHIPS, RECIPE.RICE_EGG, RECIPE.FRIED_RICE, RECIPE.NOODLE_SOUP],
        ingredients     : [ING.RICE, ING.FISH, ING.EGG, ING.SHRIMP, ING.VEGGIE, ING.NOODLE, ING.ONION, ING.SAUCE],
        star_thresholds : [800, 1200, 1800],
        goal_score      : 1200
    };

    global.level_data[LEVEL.PIZZA_PALACE] = {
        name            : "Pizza Palace",
        icon            : spr_level_pizza,
        duration        : 120,
        max_orders      : 7,
        order_interval  : 7,
        recipes         : [RECIPE.PIZZA, RECIPE.CHEESEBURGER, RECIPE.RAMEN, RECIPE.SANDWICH, RECIPE.SUSHI, RECIPE.BURGER],
        ingredients     : [ING.DOUGH, ING.CHEESE, ING.TOMATO, ING.VEGGIE, ING.BUN, ING.PATTY, ING.LETTUCE, ING.NOODLE, ING.EGG, ING.CHICKEN, ING.ONION, ING.BREAD],
        star_thresholds : [1000, 1500, 2200],
        goal_score      : 1500
    };

    global.level_data[LEVEL.GRAND_RESTAURANT] = {
        name            : "Grand Restaurant",
        icon            : spr_level_grand,
        duration        : 130,
        max_orders      : 8,
        order_interval  : 6,
        recipes         : [RECIPE.BURGER, RECIPE.CHEESEBURGER, RECIPE.RICE_EGG, RECIPE.FRIED_RICE,
                           RECIPE.NOODLE_SOUP, RECIPE.SHRIMP_RICE, RECIPE.FISH_CHIPS, RECIPE.CHICKEN_RICE,
                           RECIPE.PIZZA, RECIPE.SANDWICH, RECIPE.SUSHI, RECIPE.RAMEN],
        ingredients     : [ING.BUN, ING.PATTY, ING.CHEESE, ING.LETTUCE, ING.TOMATO, ING.ONION,
                           ING.RICE, ING.NOODLE, ING.EGG, ING.SHRIMP, ING.CHICKEN, ING.FISH,
                           ING.SAUCE, ING.VEGGIE, ING.BREAD, ING.DOUGH],
        star_thresholds : [1300, 2000, 3000],
        goal_score      : 2000
    };
}
