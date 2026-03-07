# 🍔 FOOD RUSH — GameMaker Studio 2 Project Guide

## Project Overview
**Food Rush** is a time-management restaurant game with 6 levels, 12 recipes, 16 ingredients,
combo systems, animated UI, and persistent save data.

---

## 📁 File Structure (this package)

```
FoodRush_GMS2/
├── scripts/
│   ├── scr_constants.gml      ← All enums, macros, colors
│   ├── scr_data_init.gml      ← Ingredient / Recipe / Level definitions
│   ├── scr_save.gml           ← Save/load via ini file
│   ├── scr_orders.gml         ← Spawn, tick, serve, expire logic
│   └── scr_utils.gml          ← Helper functions (match, draw, format)
│
├── objects/
│   ├── obj_game_manager.gml   ← Persistent master controller
│   ├── obj_ui_hud.gml         ← Top HUD bar (score, timer, lives)
│   ├── obj_ui_ingredients.gml ← Left panel ingredient buttons
│   ├── obj_ui_tray.gml        ← Assembly tray + Serve button
│   ├── obj_ui_orders.gml      ← Right panel customer orders
│   ├── obj_ui_pause_result.gml← Pause overlay + Result screen
│   ├── obj_title_levelselect.gml ← Title screen + Level select
│   └── obj_fx_text.gml        ← Floating score popup effect
│
└── notes/
    └── README.md              ← This file
```

---

## 🚀 Setup Steps in GameMaker Studio 2

### 1. Create a new GMS2 project
- File → New → GameMaker Language project
- Name it **FoodRush**
- Set room size: **1280 × 720**

---

### 2. Game Settings
- Game Options → General:
  - Display Name: **Food Rush**
  - Default room size: 1280 × 720
  - Enable **vsync**

---

### 3. Create Rooms (in this order)
| Room Name        | Size       | Notes                          |
|------------------|------------|--------------------------------|
| `rm_title`       | 1280 × 720 | Place `obj_game_manager` here  |
| `rm_level_select`| 1280 × 720 |                                |
| `rm_game`        | 1280 × 720 |                                |

Room order in the resource tree must be `rm_title` first.

---

### 4. Create Layers in rm_game
| Layer Name   | Type     | Depth |
|--------------|----------|-------|
| Background   | Tile/BG  | 100   |
| World        | Instance | 0     |
| UI           | Instance | -100  |
| FX           | Instance | -200  |

---

### 5. Create Sprites
Create placeholder sprites (you can replace with pixel art later):

**Ingredient sprites** (64×64 each, named exactly):
```
spr_ing_bun, spr_ing_patty, spr_ing_cheese, spr_ing_lettuce,
spr_ing_tomato, spr_ing_onion, spr_ing_rice, spr_ing_noodle,
spr_ing_egg, spr_ing_shrimp, spr_ing_chicken, spr_ing_fish,
spr_ing_sauce, spr_ing_veggie, spr_ing_bread, spr_ing_dough
```
*Quick start: Use colored squares with emoji text drawn on them.*

**Dish sprites** (96×96 each):
```
spr_dish_burger, spr_dish_cheeseburger, spr_dish_rice_egg,
spr_dish_fried_rice, spr_dish_noodle_soup, spr_dish_shrimp_rice,
spr_dish_fish_chips, spr_dish_chicken_rice, spr_dish_pizza,
spr_dish_sandwich, spr_dish_sushi, spr_dish_ramen
```

**Customer avatars** (48×48 each):
```
spr_avatar_0 through spr_avatar_11  (12 total)
```
*Use simple face icons or colored circles with letters.*

**Level icons** (80×80):
```
spr_level_stall, spr_level_truck, spr_level_noodle,
spr_level_sushi, spr_level_pizza, spr_level_grand
```

---

### 6. Create Fonts
| Asset Name      | Font           | Size | Style  | Use              |
|-----------------|----------------|------|--------|------------------|
| `fnt_logo`      | any bold serif | 72   | Bold   | Title screen logo|
| `fnt_title`     | any bold       | 32   | Bold   | Popup titles     |
| `fnt_bold_big`  | any            | 22   | Bold   | Scores, buttons  |
| `fnt_bold`      | any            | 18   | Bold   | Labels           |
| `fnt_small`     | any            | 14   | Normal | Descriptions     |
| `fnt_tiny`      | any            | 11   | Normal | Tiny info text   |
| `fnt_label`     | any            | 13   | Bold   | Section labels   |
| `fnt_italic`    | any            | 14   | Italic | Placeholder text |
| `fnt_fx`        | any bold       | 28   | Bold   | Floating scores  |
| `fnt_emoji`     | any            | 24   | Normal | Emoji rendering  |
| `fnt_emoji_large| any            | 48   | Normal | Large emoji      |
| `fnt_star`      | any            | 36   | Normal | Star rating      |

*Recommended free font: "Nunito" (Google Fonts) for body, "Fredoka One" for logo.*

---

### 7. Create Sound Assets
```
snd_click       ← short UI click
snd_serve       ← satisfying "ding" or whoosh
snd_fail        ← error buzz
snd_combo       ← combo jingle
snd_tick        ← order arrival sound
snd_bgm_title   ← looping title music
snd_bgm_game    ← looping gameplay music
```
*You can use free sounds from freesound.org or GMS2's built-in audio tools.*

---

### 8. Create Scripts
Copy each `.gml` file's contents into a new GMS2 Script:
- `scr_constants` → paste `scr_constants.gml`
- `scr_data_init` → paste `scr_data_init.gml`
- `scr_save`      → paste `scr_save.gml`
- `scr_orders`    → paste `scr_orders.gml`
- `scr_utils`     → paste `scr_utils.gml`

---

### 9. Create Objects
For each object, create it in GMS2 then paste the events from the `.gml` files.
Each event is clearly marked with `// ╔══ EVENT NAME ══╗` comments.

**Important:** Event code is written in block comments `/* ... */` —
**copy only the code inside the comments** into the corresponding GMS2 event.

| Object                  | Persistent | Visible | Room            |
|-------------------------|------------|---------|-----------------|
| `obj_game_manager`      | ✅ YES     | ❌ No   | rm_title (place)|
| `obj_title_screen`      | No         | ✅ Yes  | rm_title        |
| `obj_level_select`      | No         | ✅ Yes  | rm_level_select |
| `obj_ui_hud`            | No         | ✅ Yes  | rm_game         |
| `obj_ui_ingredients`    | No         | ✅ Yes  | rm_game         |
| `obj_ui_tray`           | No         | ✅ Yes  | rm_game         |
| `obj_ui_orders`         | No         | ✅ Yes  | rm_game         |
| `obj_ui_pause`          | No         | ✅ Yes  | (spawned)       |
| `obj_ui_result`         | No         | ✅ Yes  | rm_game (place) |
| `obj_fx_text`           | No         | ✅ Yes  | (spawned)       |

---

### 10. Place Objects in Rooms

**rm_title:**
- `obj_game_manager` (mark persistent=true)
- `obj_title_screen`

**rm_level_select:**
- `obj_level_select`

**rm_game:**
- `obj_ui_hud`
- `obj_ui_ingredients`
- `obj_ui_tray`
- `obj_ui_orders`
- `obj_ui_result` (starts invisible)

---

## 🎮 Gameplay Flow

```
rm_title
  → [Play] → rm_level_select
               → [Level card] → scr_start_level() → rm_game
                                  → [Time up / 0 lives] → scr_end_level()
                                                          → obj_ui_result shows
                                  → [Retry] → scr_start_level() again
                                  → [Menu]  → rm_level_select
```

---

## 🔑 Key Systems Summary

| System           | Script/Object              | How it works                        |
|------------------|----------------------------|-------------------------------------|
| Data             | `scr_data_init`            | Arrays of structs in `global.xxx`   |
| Save/Load        | `scr_save`                 | ini file, per-level best scores     |
| Order Spawning   | `scr_orders` → `scr_spawn_order` | timer-based, recipe from level pool |
| Order Matching   | `scr_utils` → `scr_tray_matches` | sort both arrays, compare element-by-element |
| Serving          | `scr_orders` → `scr_serve_dish`  | time bonus + combo multiplier       |
| Combo            | `global.session_combo` + decay timer (8s) | multiplies base points by 1+combo*0.25 |
| Difficulty Scale | `global.difficulty = 1 + score/3000` | reduces order spawn interval |

---

## 💡 Tips for Development

1. **Start with placeholder sprites** — colored boxes work fine to test logic first
2. **Use F8 debug console** to print `global.session_score` and verify scoring
3. **Test level 1 first** — it has the fewest ingredients and slowest order rate
4. **GUI coordinates** — all UI uses `Draw GUI` event with `display_get_gui_width/height()`
5. **Room transitions** — `room_goto()` handles cleanup automatically since objects aren't persistent (except `obj_game_manager`)

---

## 🎨 Recommended Art Style
- **Pixel art** at 2x scale — crisp and clean
- Warm color palette: oranges, yellows, browns
- Each ingredient: recognizable icon on transparent bg
- UI panels: dark surface with orange accents

---

*Made with ❤️ — Food Rush v1.0*
