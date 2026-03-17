# Assets Folder Structure

This folder contains all pixel art assets for the Laundry Day game.

## Directory Layout

```
assets/
├── COLOR_PALETTE.json          # Import into Aseprite/Krita for consistency
├── environment/                # Background & static environment
│   ├── laundry_room_bg.png    # Main background (1280×720)
│   ├── baskets/               # Individual basket assets
│   │   ├── basket_dirty.png
│   │   ├── basket_clean.png
│   │   ├── basket_sorted.png
│   │   └── basket_darks.png
│   └── washing_machine/       # Machine components
│       ├── machine_body.png
│       ├── machine_door_open.png
│       ├── machine_door_closed.png
│       ├── machine_panel.png
│       └── machine_running.png
├── clothing/                   # Clothing item sprites
│   ├── tshirt_red.png         # 64×64 variants
│   ├── tshirt_blue.png
│   ├── tshirt_green.png
│   ├── tshirt_purple.png
│   ├── tshirt_gray.png
│   ├── jeans_dark.png
│   ├── jeans_light.png
│   ├── jeans_black.png
│   ├── sweater_brown.png
│   ├── sweater_cream.png
│   ├── sweater_navy.png
│   ├── sweater_pink.png
│   ├── socks_white.png
│   ├── socks_black.png
│   ├── socks_gray.png
│   ├── socks_striped.png
│   ├── underwear_white.png
│   ├── underwear_beige.png
│   └── underwear_black.png
├── ui/                         # User interface assets
│   ├── buttons/
│   │   ├── btn_standard.png           # 64×64
│   │   ├── btn_standard_hover.png
│   │   ├── btn_standard_active.png
│   │   └── btn_states.png            # 192×64 (3 frames)
│   ├── progress_bar.png              # 80×16
│   ├── progress_fill.png             # Reusable fill gradient
│   ├── magnifying_glass.png          # 96×96 inspection tool
│   └── care_icons/
│       ├── temp_cold.png             # 48×48 each
│       ├── temp_warm.png
│       ├── temp_hot.png
│       ├── fabric_delicate.png
│       ├── fabric_normal.png
│       ├── fabric_heavy.png
│       ├── dry_air.png
│       ├── dry_tumble.png
│       ├── dry_no.png
│       ├── bleach_yes.png
│       ├── bleach_no.png
│       ├── iron_yes.png
│       └── iron_no.png
├── animations/                 # Sprite sheet animations
│   ├── door_open.png          # 8 frames, 640×80 (80×80 each)
│   ├── clothes_spin.png       # 16 frames spinning animation
│   └── steam_wisps.png        # 12 frames particle effect
└── _src/                       # Source files (Aseprite/Krita projects)
    ├── clothing/              # Original .aseprite files
    ├── ui/
    └── environment/
```

## Asset Specifications

### File Format
- **Format**: PNG with transparency (RGBA)
- **Anti-aliasing**: None (crisp pixel edges)
- **Color depth**: 8-bit indexed (use COLOR_PALETTE.json)
- **Scaling**: No scaling on export - export at native resolution

### Naming Convention
- Lowercase with underscores: `tshirt_red.png`
- Include size variant if applicable: `button_small.png`, `button_large.png`
- Use descriptive names: `basket_dirty.png` not `basket_1.png`

### Size Standards

| Asset Type | Size | Usage |
|-----------|------|-------|
| Clothing items | 64×64 | Inventory, baskets |
| Baskets | 96×96 | Floor placement |
| UI buttons | 64×64 | Interactive elements |
| Care icons | 48×48 | Label display |
| Magnifying glass | 96×96 | Inspection tool |
| Progress bar | 80×16 | Status indicators |
| Washing machine | 256×256 | Main environment |
| Background | 1280×720 | Full screen |

## Generation & Import Workflow

### 1. Generate Assets
- Use prompts from `docs/AI_GENERATION_PROMPTS.md`
- Save to temporary folder, preview quality
- If acceptable, proceed to step 2; otherwise regenerate

### 2. Prepare in Aseprite/Krita
- Open generated PNG
- Apply color correction to match palette
- Remove anti-aliasing
- Snap to 16×16 grid
- Verify transparency
- Save source file in `_src/` folder
- Export to appropriate `assets/` subfolder

### 3. Verify Quality
- Check at 2x and 4x zoom
- Verify colors match palette
- Ensure consistent line weights
- Check transparent background

### 4. Integrate into Project
- Copy final PNG to correct folder
- Update asset manifest (when building game)
- Test in-game rendering

## Color Palette Import

### Aseprite
1. File → Import Palette
2. Select `COLOR_PALETTE.json`
3. Palette window will show all colors
4. Use eyedropper to sample colors during creation

### Krita
1. Windows → Dockable Dialogs → Palette
2. Import palette from file
3. Dockable dialog shows all colors
4. Left-click to set foreground, right-click for background

## Animation Sheets

Animations are exported as horizontal sprite sheets:
```
Format: frame1 | frame2 | frame3 | ... | frameN
Height: Single frame height
Width: Frame width × number of frames
Example: door_open.png = 80×80 pixels × 8 frames = 640×80 total
```

Import as sprite sheet in engine with frame dimensions specified.

## Quality Checklist

Before committing assets:
- [ ] PNG with transparency (RGBA)
- [ ] Correct dimensions per spec
- [ ] Colors match palette
- [ ] No anti-aliasing artifacts
- [ ] 2px consistent line weight
- [ ] Transparent background
- [ ] File named correctly
- [ ] Placed in correct folder
- [ ] Source file backed up in `_src/`

## Notes

- Keep high-quality source files in `_src/` for future edits
- Don't delete generated assets; they're your design reference
- If regenerating assets, bump version: `tshirt_red_v2.png`
- Test assets together in-game before considering complete
- Maintain consistent style across all assets (line weight, colors, perspective)
