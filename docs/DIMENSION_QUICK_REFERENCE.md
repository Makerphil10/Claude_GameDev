# Dimension Quick Reference Card
## Keep this open while creating assets!

---

## 🎨 ASSET DIMENSIONS AT A GLANCE

### Environment
```
┌─────────────────────────────────────────┐
│ LAUNDRY ROOM BACKGROUND                 │
│ 1280 × 720 pixels                       │
│ Full game viewport                      │
│ Contains: walls, floor, shelves, setup  │
└─────────────────────────────────────────┘

┌────────────────┐     ┌────────────────┐
│   BASKET       │     │   BASKET       │
│  96 × 96 px    │ ... │  96 × 96 px    │
│  × 4 types     │     │  (dirty, clean,│
│                │     │   sorted,      │
│                │     │   darks)       │
└────────────────┘     └────────────────┘
```

### Clothing Items (all 64×64)
```
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
│ T-Shirt │ │  Jeans  │ │ Sweater │ │ Socks   │ │Underwear│
│64 × 64px│ │64 × 64px│ │64 × 64px│ │64 × 64px│ │64 × 64px│
│× 5 color│ │× 3 color│ │× 4 color│ │× 4 type │ │× 3 color│
└─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘
```

### UI Elements
```
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ CARE ICONS   │  │   BUTTON     │  │   PROGRESS   │
│ 48 × 48 px   │  │  64 × 64 px  │  │   80 × 16 px │
│ × 13 icons   │  │  × 3 states  │  │ (+ fill bar) │
└──────────────┘  └──────────────┘  └──────────────┘

┌──────────────────────┐
│ MAGNIFYING GLASS     │
│   96 × 96 pixels     │
│ (inspection tool)    │
└──────────────────────┘
```

### Washing Machine
```
┌─────────────────────────────┐
│   WASHING MACHINE           │
│      256 × 256 px           │
│  (main body + components)   │
│                             │
│  Components:                │
│  - Door (closed) 80×80      │
│  - Door (open) 80×80        │
│  - Panel 128×64             │
└─────────────────────────────┘
```

### Animations (Sprite Sheets)
```
┌────┬────┬────┬────┬────┬────┬────┬────┐
│ F1 │ F2 │ F3 │ F4 │ F5 │ F6 │ F7 │ F8 │  8 frames × 80×80 = 640×80
└────┴────┴────┴────┴────┴────┴────┴────┘

Door Open Animation

┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│ F1  │ F2  │ F3  │ F4  │ F5  │ F6  │ F7  │ F8  │ F9  │ F10 │ F11 │ F12 │  12 frames × 96×96 = 1152×96
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘

Clothes Spin Animation
```

---

## 📏 GRID & PRECISION

### Base Grid System
```
Asset Grid Alignment: 16×16 pixels
(All assets snap to 16×16 grid for consistency)

Example 64×64 item with grid:
┌────┬────┬────┬────┐
│    │    │    │    │ 4 × 4 grid blocks = 64×64
├────┼────┼────┼────┤
│    │    │    │    │
├────┼────┼────┼────┤
│    │    │    │    │
├────┼────┼────┼────┤
│    │    │    │    │
└────┴────┴────┴────┘

Pixel Outline Weight: 2 pixels (standard for all assets)
```

### Isometric View Notes
```
Top-down 3/4 angle view (looking down at items)
Y-offset: 32 pixels per row for isometric spacing
No extreme angles - keep flat, readable style
```

---

## 🎨 COLOR PALETTE (Quick Reference)

### Neutral Base
| Color | Hex | Use |
|-------|-----|-----|
| Cream | #F5F1E8 | Primary BG |
| Beige | #E8DCC8 | Secondary BG |
| Gray | #C4B5A0 | Mid-tone |
| Dark Brown | #5D4E37 | Outlines |

### Accent Colors
| Color | Hex | Use |
|-------|-----|-----|
| Soft Blue | #7DAAC1 | Clothing/UI |
| Purple | #8B7BA8 | Clothing/Accents |
| Green | #A8C68F | Clothing/Accents |
| Orange | #D4956E | Highlights |

### Functional
| Color | Hex | Use |
|-------|-----|-----|
| Success | #6BA86F | Positive |
| Alert | #D46464 | Warning |
| Warning | #F4D35E | Caution |
| Text | #2C2416 | Text/Details |

### Clothing Additions
| Color | Hex | Use |
|-------|-----|-----|
| White | #FFFFFF | Light items |
| Black | #1A1A1A | Dark items |
| Light Gray | #E2E2E2 | Alternatives |

---

## 📋 NAMING CONVENTION EXAMPLES

```
CORRECT ✓                      WRONG ✗
tshirt_red.png                 tshirt1.png
jeans_dark.png                 pants_dark_v2.png
basket_dirty.png               basket.png
sweater_brown.png              brown_sweater.png
socks_striped.png              sock_pattern.png
temp_cold.png                  icon_cold.png
btn_standard.png               button.png
machine_body.png               washer.png
care_icons/iron_yes.png        icons/iron.png
```

**Pattern**: `[type]_[variant].png` (all lowercase, underscores)

---

## 🚀 ASEPRITE/KRITA QUICK SETUP

### Before You Start
```
File > Preferences > Grid Settings
  Width: 16 pixels
  Height: 16 pixels
  Offset X: 0
  Offset Y: 0

View > Snap > Snap to Grid ✓ (enabled)

Windows > Dockable Dialogs > Palette
  Import > COLOR_PALETTE.json
```

### Export Settings (Every Time)
```
File > Export As
  Format: PNG
  Options:
    ☑ RGBA (transparency)
    ☐ Interlaced
  Compression: Normal

  Location: assets/[category]/
  Filename: [correct_name].png
```

---

## 🔍 SIZE COMPARISON CHART

```
Visual Scale (relative sizes):

Clothing item:        ██       (64×64)
Basket:               ███      (96×96)
Care icon:            ██       (48×48)
Button:               ██       (64×64)
Magnifying glass:     ███      (96×96)
Washing machine:      ████████ (256×256)
Background:           ████████████████ (1280×720)
                      (not to scale!)
```

---

## 📊 BATCH GENERATION DIMENSIONS

### When Generating Multiple Assets Together

```
T-SHIRTS × 5:
  Size: 64×64
  Variants: Red, Blue, Green, Purple, Gray
  Total area: 320×64 (if stitched) or 5 × 64×64

JEANS × 3:
  Size: 64×64
  Variants: Dark, Light, Black
  Total area: 192×64 (if stitched) or 3 × 64×64

CARE ICONS × 13:
  Size: 48×48 each
  Grouped by type (temp, fabric, dry, bleach, iron)
  Total area: varies by grouping

BUTTONS × 3 STATES:
  Size: 64×64 each
  States: Default, Hover, Active
  Total area: 192×64 (horizontal strip)
```

---

## ⚡ QUICK TASK TEMPLATES

### New Clothing Item (Use as Template)
```
1. Size: 64×64 px
2. Grid: 16×16 snap
3. Colors: From palette only
4. Outlines: 2 px weight
5. Style: Front view, slightly 3/4 angle
6. Export: assets/clothing/[type]_[color].png
7. Source: assets/_src/clothing/[type]_[color].aseprite
```

### New Icon (Use as Template)
```
1. Size: 48×48 px
2. Grid: 16×16 snap
3. Colors: Line style (#2C2416 mainly)
4. Outlines: 2 px weight
5. Style: Minimalist, educational
6. Export: assets/ui/care_icons/[type]_[variant].png
7. Source: assets/_src/ui/[type]_[variant].aseprite
```

### New Environment Asset (Use as Template)
```
1. Size: Varies (see dimensions above)
2. Grid: 16×16 snap
3. Colors: Full palette
4. Outlines: 2 px weight
5. Style: Isometric 3/4 view
6. Export: assets/environment/[category]/[name].png
7. Source: assets/_src/environment/[category]/[name].aseprite
```

---

## ✅ PRE-EXPORT VERIFICATION

Before exporting, check:

```
[ ] Dimensions match spec (64×64, 96×96, etc.)
[ ] Grid View enabled (shows 16×16 grid)
[ ] All pixels snapped to grid (no off-grid pixels)
[ ] Colors from palette only (no off-palette colors)
[ ] Transparent background (not white/gray)
[ ] Outline weight consistent (2 pixels)
[ ] No anti-aliasing (crisp edges)
[ ] Asset readable at 2x zoom
[ ] Asset readable at 4x zoom
[ ] Filename correct format (lowercase_underscore.png)
[ ] Saving to correct folder
```

---

## 🎯 TARGET COMPLETION TIMES

| Component | Qty | Gen Time | Touchup | Total |
|-----------|-----|----------|---------|-------|
| Background | 1 | 5 min | 15 min | 20 min |
| Baskets | 4 | 10 min | 20 min | 30 min |
| **Phase 1** | 5 | - | - | **50 min** |
| T-shirts | 5 | 5 min | 20 min | 25 min |
| Jeans | 3 | 3 min | 15 min | 18 min |
| Sweaters | 4 | 4 min | 15 min | 19 min |
| Socks | 4 | 4 min | 15 min | 19 min |
| Underwear | 3 | 3 min | 12 min | 15 min |
| **Phase 2** | 19 | - | - | **96 min** |
| Care icons | 13 | 10 min | 20 min | 30 min |
| **Phase 3** | 13 | - | - | **30 min** |
| Buttons | 3 | 3 min | 10 min | 13 min |
| Progress bar | 2 | 2 min | 5 min | 7 min |
| Mag glass | 1 | 2 min | 5 min | 7 min |
| **Phase 4** | 6 | - | - | **27 min** |
| Wash machine | 5 | 5 min | 20 min | 25 min |
| **Phase 5** | 5 | - | - | **25 min** |
| **TOTAL** | **48** | **~47 min** | **~132 min** | **~180 min** |

---

## 🎨 PRINT THIS PAGE!

Bookmark this page or print it out to keep at your desk while creating assets. Reference it constantly for:
- Asset dimensions
- Grid settings
- Color codes
- Naming conventions
- Quick checklist

---

**Version**: 1.0
**Last Updated**: 2026-03-17
**Status**: Ready for asset creation!
