# Asset Creation Checklist

Quick reference guide for generating and preparing pixel art assets for Laundry Day game.

---

## PHASE 1: Background & Baskets (Priority 1)

### Laundry Room Background (1280×720)
- [ ] Generate using prompt from `AI_GENERATION_PROMPTS.md` section 1
- [ ] Generate 3-4 variations
- [ ] Pick best layout option
- [ ] Touch up in Aseprite/Krita:
  - [ ] Remove anti-aliasing
  - [ ] Snap to 16×16 grid
  - [ ] Correct colors to match palette
  - [ ] Verify transparency
- [ ] Export as `environment/laundry_room_bg.png`
- [ ] Save source file as `_src/environment/laundry_room_bg.aseprite`

### Basket - Dirty Clothes (96×96)
- [ ] Generate using prompt from section 2.1
- [ ] Touch up: color, grid snapping, transparency
- [ ] Export as `environment/baskets/basket_dirty.png`
- [ ] Save source file

### Basket - Clean (96×96)
- [ ] Generate using prompt from section 2.1
- [ ] Touch up: color, grid snapping, transparency
- [ ] Export as `environment/baskets/basket_clean.png`
- [ ] Save source file

### Basket - Sorted (96×96, purple)
- [ ] Generate using prompt from section 2.1
- [ ] Touch up: color, grid snapping, transparency
- [ ] Export as `environment/baskets/basket_sorted.png`
- [ ] Save source file

### Basket - Darks (96×96, dark gray)
- [ ] Generate using prompt from section 2.1
- [ ] Touch up: color, grid snapping, transparency
- [ ] Export as `environment/baskets/basket_darks.png`
- [ ] Save source file

---

## PHASE 2: Clothing Items (Priority 2)

### T-Shirts (64×64) - 5 Color Variants
- [ ] Generate RED variant
- [ ] Generate BLUE variant
- [ ] Generate GREEN variant
- [ ] Generate PURPLE variant
- [ ] Generate GRAY variant
- [ ] Touch up each: color correction, grid snapping, transparency
- [ ] Export as `clothing/tshirt_red.png`, `tshirt_blue.png`, etc.
- [ ] Save source files

### Jeans (64×64) - 3 Color Variants
- [ ] Generate DARK BLUE variant
- [ ] Generate LIGHT BLUE variant
- [ ] Generate BLACK variant
- [ ] Touch up each: detail clarity, grid snapping, transparency
- [ ] Export as `clothing/jeans_dark.png`, `jeans_light.png`, `jeans_black.png`
- [ ] Save source files

### Sweaters/Hoodies (64×64) - 4 Variants
- [ ] Generate BROWN variant
- [ ] Generate CREAM variant
- [ ] Generate NAVY variant
- [ ] Generate PINK variant
- [ ] Touch up each: texture clarity, grid snapping, transparency
- [ ] Export as `clothing/sweater_brown.png`, etc.
- [ ] Save source files

### Socks (64×64) - 4 Variants
- [ ] Generate WHITE variant
- [ ] Generate BLACK variant
- [ ] Generate GRAY variant
- [ ] Generate STRIPED variant
- [ ] Touch up each: fold detail, grid snapping, transparency
- [ ] Export as `clothing/socks_white.png`, etc.
- [ ] Save source files

### Underwear (64×64) - 3 Variants
- [ ] Generate WHITE variant
- [ ] Generate BEIGE variant
- [ ] Generate BLACK variant
- [ ] Touch up each: clarity, grid snapping, transparency
- [ ] Export as `clothing/underwear_white.png`, etc.
- [ ] Save source files

---

## PHASE 3: Care Label Icons (Priority 3)

### Temperature Icons (48×48)
- [ ] Generate COLD (snowflake)
- [ ] Generate WARM (wave)
- [ ] Generate HOT (wavy lines)
- [ ] Touch up: line consistency, grid snapping, transparency
- [ ] Export as `ui/care_icons/temp_cold.png`, etc.
- [ ] Save source files

### Fabric Care Icons (48×48)
- [ ] Generate DELICATE (flower)
- [ ] Generate NORMAL (circle)
- [ ] Generate HEAVY (square)
- [ ] Touch up: line consistency, grid snapping, transparency
- [ ] Export as `ui/care_icons/fabric_delicate.png`, etc.
- [ ] Save source files

### Drying Icons (48×48)
- [ ] Generate AIR DRY
- [ ] Generate TUMBLE
- [ ] Generate NO DRY
- [ ] Touch up: line consistency, grid snapping, transparency
- [ ] Export as `ui/care_icons/dry_air.png`, etc.
- [ ] Save source files

### Bleach Icons (48×48)
- [ ] Generate ALLOWED
- [ ] Generate NOT ALLOWED
- [ ] Touch up: line consistency, grid snapping, transparency
- [ ] Export as `ui/care_icons/bleach_yes.png`, `bleach_no.png`
- [ ] Save source files

### Ironing Icons (48×48)
- [ ] Generate ALLOWED
- [ ] Generate NOT ALLOWED
- [ ] Touch up: line consistency, grid snapping, transparency
- [ ] Export as `ui/care_icons/iron_yes.png`, `iron_no.png`
- [ ] Save source files

---

## PHASE 4: UI Elements (Priority 4)

### Buttons (64×64)
- [ ] Generate STANDARD button (default state)
- [ ] Generate HOVER state (lighter)
- [ ] Generate ACTIVE state (darker/pressed)
- [ ] Touch up: color accuracy, grid snapping, transparency
- [ ] Export as:
  - [ ] `ui/buttons/btn_standard.png`
  - [ ] `ui/buttons/btn_standard_hover.png`
  - [ ] `ui/buttons/btn_standard_active.png`
- [ ] Optionally create combined sheet: `btn_states.png` (192×64, 3 frames)
- [ ] Save source files

### Progress Bar (80×16)
- [ ] Generate empty state
- [ ] Generate fill element
- [ ] Touch up: color accuracy, grid snapping, transparency
- [ ] Export as:
  - [ ] `ui/progress_bar.png` (empty state)
  - [ ] `ui/progress_fill.png` (fill layer)
- [ ] Save source files

### Magnifying Glass (96×96)
- [ ] Generate magnifying glass inspection tool
- [ ] Touch up: circle clarity, handle detail, shadow, transparency
- [ ] Export as `ui/magnifying_glass.png`
- [ ] Save source file

---

## PHASE 5: Washing Machine (Priority 5)

### Machine Body (256×256)
- [ ] Generate main machine body
- [ ] Touch up: proportions, control panel clarity, grid snapping, transparency
- [ ] Export as `environment/washing_machine/machine_body.png`
- [ ] Save source file

### Machine Door - Closed
- [ ] Generate closed door state
- [ ] Touch up: glass shine, clarity, transparency
- [ ] Export as `environment/washing_machine/machine_door_closed.png`
- [ ] Save source file

### Machine Door - Open
- [ ] Generate open door state
- [ ] Touch up: interior drum detail, grid snapping, transparency
- [ ] Export as `environment/washing_machine/machine_door_open.png`
- [ ] Save source file

### Machine Control Panel (128×64)
- [ ] Generate control panel with dials/buttons/display
- [ ] Touch up: button clarity, text readability, color accuracy
- [ ] Export as `environment/washing_machine/machine_panel.png`
- [ ] Save source file

### Machine Running Animation (optional)
- [ ] Create spinning clothes inside machine
- [ ] 8-12 frames of rotation
- [ ] Export as sprite sheet: `animations/clothes_spin.png`
- [ ] Save source file

---

## QUALITY VERIFICATION

Before marking complete, check each asset:

### Visual Quality
- [ ] Consistent line weight (2px outlines)
- [ ] Colors match palette hex codes
- [ ] No anti-aliasing artifacts
- [ ] Isometric perspective correct
- [ ] Cute/cozy aesthetic maintained
- [ ] Readable at intended display size

### Technical Quality
- [ ] PNG format with RGBA transparency
- [ ] Correct dimensions per spec
- [ ] Transparent background
- [ ] Snapped to 16×16 grid
- [ ] No scaling artifacts
- [ ] File named correctly
- [ ] Placed in correct folder

### Integration Ready
- [ ] Source file backed up in `_src/`
- [ ] All assets organized by category
- [ ] Color palette applied consistently
- [ ] Animation sheets formatted correctly (if applicable)
- [ ] Ready for game engine integration

---

## QUICK STATS

| Phase | Assets | Est. Time | Priority |
|-------|--------|-----------|----------|
| 1 | 5 | 1-2h | First |
| 2 | 17 | 1-2h | Second |
| 3 | 13 | 30m | Third |
| 4 | 3 | 30m | Fourth |
| 5 | 5 | 1h | Fifth |
| **Total** | **43** | **4-5h** | **Core Game Ready** |

---

## TIPS & TRICKS

### Batch Generation Efficiency
1. Write all prompts in a text file
2. Use AI tool's batch/queue feature if available
3. Generate all variants of one asset type together
4. Review all variants of same type before touchup (pick best)

### Aseprite Keyboard Shortcuts
- `Ctrl+Shift+O`: Snap to grid
- `View > Snap > Snap to Grid`: Toggle grid snapping
- `Ctrl+Alt+O`: Color palette
- `Select > Color Range`: Select anti-aliased edges for cleanup

### Krita Keyboard Shortcuts
- `Ctrl+Shift+T`: Toggle grid
- `Windows > Dockable Dialogs > Palette`: Show palette
- `Ctrl+U`: Color to alpha (remove color)

### Common Touchup Tasks
- **Remove anti-aliasing**: Select > Color Range > adjust threshold
- **Fix transparency**: Select > By Color > background color > Delete
- **Correct colors**: Colors > Hue-Saturation > adjust to palette
- **Snap pixels**: Move tool + holding Shift to grid

### Testing Assets In-Game
- Create test scene with placeholder assets first
- Load final assets incrementally
- Check scaling/rendering at 1x, 2x, 4x zoom
- Verify transparency blending

---

## TROUBLESHOOTING

### Issue: Generated assets have anti-aliasing
**Solution**: In Aseprite, Select > Color Range, adjust threshold to select edges, delete layer, adjust remaining pixels manually

### Issue: Colors don't match palette
**Solution**: Use Colors > Indexed Mode to convert to indexed palette, or manually replace colors with eyedropper + bucket fill

### Issue: Assets look jagged or misaligned
**Solution**: Ensure grid snapping is ON, manually adjust pixels that don't align to 16×16 grid

### Issue: Transparency is wrong
**Solution**: Layer > Transparency > Color to Alpha, select background color, adjust threshold

### Issue: Assets look inconsistent with each other
**Solution**: Review line weights (should all be 2px), check color accuracy, verify perspective angle is consistent

---

## NEXT STEPS AFTER ASSET COMPLETION

Once all assets are complete and verified:

1. **Integrate into game engine**
   - Import PNG assets to game folder
   - Create sprite managers/loaders
   - Test rendering

2. **Create animations**
   - Door opening/closing (8 frames)
   - Clothes spinning (12 frames)
   - Steam wisps (8 frames)

3. **Sound design** (next phase)
   - Water/washing sounds
   - Button click SFX
   - Success chimes

4. **Game logic integration**
   - Load assets in main scene
   - Connect UI buttons
   - Test gameplay loop
