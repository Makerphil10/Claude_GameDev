# Getting Started with Asset Creation
## Quick Start Guide

This guide walks you through creating pixel art assets for Laundry Day game using AI generation + manual touchup.

---

## 📋 What You'll Create

**Total: ~43 assets** covering:
- 1 background (laundry room)
- 4 baskets
- 17 clothing items (5 colors each, 3 types)
- 13 UI/care label icons
- 3 UI elements (buttons, progress bar, magnifying glass)
- 4+ washing machine components

**Estimated Time**: 4-5 hours total (AI generation + touchup)

---

## 🛠️ Tools You'll Need

### Essential
- **AI Image Generator**: Midjourney, DALL-E 3, Stable Diffusion, or ComfyUI
- **Pixel Art Editor**: Aseprite or Krita (both on your system)
- **Text Editor**: Any editor for reference docs

### Optional
- Color picker tool
- Sprite sheet generator
- Animation preview tool

---

## 📚 Documentation Structure

| Document | Purpose | When to Use |
|----------|---------|------------|
| **VISUAL_SPEC.md** | Complete style guide, dimensions, palette | Reference while generating & touching up |
| **AI_GENERATION_PROMPTS.md** | Copy-paste prompts for AI tools | Generate assets section by section |
| **ASSET_CREATION_CHECKLIST.md** | Step-by-step task list | Track progress, mark items done |
| **COLOR_PALETTE.json** | Import into Aseprite/Krita | Color consistency during touchup |
| **assets/README.md** | Folder structure & naming | Organize finished assets |

---

## 🎨 Quick Start Workflow

### Step 1: Prepare Your Environment (5 min)
```bash
# Navigate to project
cd ~/Claude_GameDev

# Open documentation
# - VISUAL_SPEC.md (read once for overview)
# - AI_GENERATION_PROMPTS.md (keep open)
# - ASSET_CREATION_CHECKLIST.md (track progress)

# Open Aseprite/Krita
# File > Preferences > Grid > Set to 16×16 pixels
# Import COLOR_PALETTE.json
```

### Step 2: Generate Phase 1 Assets (1-2 hours)
**Background + Baskets**

1. Open `AI_GENERATION_PROMPTS.md` section 1
2. Copy prompt for "Laundry Room Background"
3. Paste into Midjourney/DALL-E/Stable Diffusion
4. Generate 3-4 variations
5. Pick the best one
6. Open in Aseprite/Krita
7. Touch up (see step 4 below)
8. Repeat for 4 basket types

**Checklist**: Mark items in `ASSET_CREATION_CHECKLIST.md` as complete

### Step 3: Generate Phase 2 Assets (1-2 hours)
**Clothing Items**

1. Copy all 5 T-shirt color prompts (modify color name)
2. Generate all 5 variants (batch if possible)
3. Touch up each one
4. Repeat for jeans, sweaters, socks, underwear
5. Organize in `assets/clothing/` folder

**Time-saving tip**: Generate all T-shirts first, then batch-touch-up while similar

### Step 4: Touch Up in Aseprite/Krita (varies)

For each generated asset:

```
1. OPEN
   - File > Open > select generated PNG

2. CLEAN
   - Image > Canvas Size > Ensure correct dimensions
   - Layer > Transparency > Color to Alpha > select background color
   - Select > Color Range > find anti-aliased edges
   - Delete anti-aliased pixels, manually adjust remaining

3. GRID SNAP
   - View > Show Grid (16×16)
   - Move pixels to align with grid
   - Use View > Zoom > 4x to work precisely

4. COLOR CORRECT
   - Use COLOR_PALETTE.json as reference
   - Colors > Hue-Saturation or bucket fill to match
   - Or: Image > Mode > Indexed > use COLOR_PALETTE.json

5. VERIFY
   - Check at 2x and 4x zoom
   - Colors match palette?
   - Transparent background?
   - 2px consistent line weight?

6. EXPORT
   - File > Export As
   - Name: lowercase_underscore.png (e.g., tshirt_red.png)
   - Format: PNG
   - Options: RGBA, no interlacing
   - Save to correct folder in assets/
   - KEEP original in _src/ for future edits
```

### Step 5: Verify Quality (30 min)
Use `ASSET_CREATION_CHECKLIST.md` quality section:
- [ ] All assets present
- [ ] Dimensions correct
- [ ] Colors match palette
- [ ] No anti-aliasing
- [ ] Transparent background
- [ ] Consistent style
- [ ] Files named correctly
- [ ] Organized in folders

---

## 🚀 Execution Plan (By Phase)

### Phase 1: Foundation (PRIORITY 1) - Start here!
**Goal**: Create basic environment so you can test placement

**Assets**:
1. Laundry room background
2. Basket (dirty)
3. Basket (clean)
4. Basket (sorted)
5. Basket (darks)

**Time**: 1-2 hours
**Commands**: See "PHASE 1" in ASSET_CREATION_CHECKLIST.md

**Why this first?**
- Establishes overall aesthetic
- Tests your workflow (generate → touchup → export)
- Provides context for other assets

---

### Phase 2: Clothing (PRIORITY 2) - Do after Phase 1
**Goal**: Create most visual assets (17 items)

**Assets**:
- 5 T-shirt colors
- 3 Jean colors
- 4 Sweater colors
- 4 Sock variants
- 3 Underwear colors

**Time**: 1-2 hours
**Commands**: See "PHASE 2" in ASSET_CREATION_CHECKLIST.md

**Tips**:
- Generate all T-shirts together for consistency
- Touch up similar items back-to-back
- Batch export saves time

---

### Phase 3: UI Icons (PRIORITY 3) - Do after Phase 2
**Goal**: Create care label educational icons

**Assets**:
- 3 Temperature icons (cold/warm/hot)
- 3 Fabric care icons (delicate/normal/heavy)
- 3 Drying icons (air/tumble/no)
- 2 Bleach icons (yes/no)
- 2 Ironing icons (yes/no)

**Time**: 30 minutes
**Commands**: See "PHASE 3" in ASSET_CREATION_CHECKLIST.md

**Note**: These are small (48×48) but important for game polish

---

### Phase 4: UI Elements (PRIORITY 4) - Do after Phase 3
**Goal**: Create interactive UI components

**Assets**:
- 3 Button states (default/hover/active)
- Progress bar + fill
- Magnifying glass tool

**Time**: 30 minutes
**Commands**: See "PHASE 4" in ASSET_CREATION_CHECKLIST.md

---

### Phase 5: Washing Machine (PRIORITY 5) - Do last
**Goal**: Create complex centerpiece asset

**Assets**:
- Machine body
- Door (closed)
- Door (open)
- Control panel
- Animation (optional)

**Time**: 1 hour
**Commands**: See "PHASE 5" in ASSET_CREATION_CHECKLIST.md

**Note**: Most complex, do after learning workflow

---

## 💡 Pro Tips

### Generation Tips
- **Batch mode**: Most AI tools let you queue multiple prompts
- **Consistency**: Use exact same prompt except for color/variant
- **Sampling**: Generate 3-4 variants, pick the best
- **Reference**: Include similar game style in prompt ("like Stardew Valley")

### Touchup Tips
- **Zoom in**: Work at 4x zoom for precision
- **Grid first**: Always snap to 16×16 grid first
- **Color palette**: Import early, reference colors while working
- **Save often**: Save Aseprite project before exporting

### Organization Tips
- **Name clearly**: `tshirt_blue.png` not `shirt_1.png`
- **Source backup**: Keep `.aseprite` files in `_src/` for edits
- **Folder structure**: Match the one in `assets/README.md`
- **Batch operations**: Touch up similar items in sequence

### Efficiency Tips
- **Aseprite filters**: Use Filters > Color Range to find background
- **Krita tools**: Ctrl+U (Color to Alpha) for transparency
- **Batch export**: Export all items of one type in one session
- **Checklist**: Mark items as you go - don't lose track

---

## 📊 Progress Tracking

Use this table to track your progress:

```markdown
## Asset Generation Progress

| Phase | Component | Status | Time Spent |
|-------|-----------|--------|-----------|
| 1 | Background | ⬜ Not Started | 0min |
| 1 | Basket (dirty) | ⬜ Not Started | 0min |
| 1 | Basket (clean) | ⬜ Not Started | 0min |
| 1 | Basket (sorted) | ⬜ Not Started | 0min |
| 1 | Basket (darks) | ⬜ Not Started | 0min |
| 2 | T-shirts (5) | ⬜ Not Started | 0min |
| ... | ... | ... | ... |
```

**Legend**: ⬜ = Not Started, 🟨 = In Progress, 🟩 = Complete

---

## 🎯 Quality Checklist (Quick Version)

Before marking asset complete, verify:

- [ ] Correct size/dimensions
- [ ] PNG with transparency
- [ ] Colors match palette
- [ ] No anti-aliasing
- [ ] Snapped to grid
- [ ] Named correctly
- [ ] In correct folder
- [ ] Source file backed up

---

## 🔧 Troubleshooting

### "My generated image has fuzzy edges"
→ Anti-aliasing. In Aseprite: Select > Color Range, adjust threshold, delete

### "Colors don't match the palette"
→ Use Image > Mode > Indexed and select COLOR_PALETTE.json, or manually replace

### "Grid snapping isn't working"
→ Make sure View > Snap > Snap to Grid is enabled (check mark visible)

### "Assets look inconsistent"
→ Check line weights (should be 2px), colors, perspective angle. Compare side-by-side

### "Export is too large/small"
→ Check Image > Canvas Size before exporting. Should match spec (64×64, 96×96, etc.)

---

## ✅ Definition of "Done"

An asset is done when:

1. **Generated**: Created via AI tool
2. **Touched up**: Cleaned, color corrected, grid snapped in Aseprite/Krita
3. **Verified**: Meets quality checklist
4. **Exported**: Saved as PNG in correct folder
5. **Backed up**: Source file saved in `_src/`
6. **Checked off**: Marked complete in ASSET_CREATION_CHECKLIST.md

---

## 🎨 Next Steps After Assets Complete

Once all assets are created:

1. **Integrate into game**
   - Import PNG files into game project
   - Create sprite loaders/managers
   - Test rendering

2. **Create animations**
   - Door opening (8 frames)
   - Clothes spinning (12 frames)
   - Particles/effects

3. **Connect UI**
   - Load buttons with states
   - Wire up progress bars
   - Implement magnifying glass interaction

4. **Polish**
   - Add shadows/lighting
   - Create particle effects
   - Sound design

---

## 📞 Getting Help

**Reference documents** (in `docs/` folder):
- `VISUAL_SPEC.md` - Full specifications
- `AI_GENERATION_PROMPTS.md` - All generation prompts
- `ASSET_CREATION_CHECKLIST.md` - Task checklist

**Common issues**:
- See "Troubleshooting" section above
- Check Aseprite/Krita documentation for tool help
- Review AI tool's documentation for generation help

---

## 🎉 You're Ready!

You have everything you need to create professional-quality pixel art assets.

**Start with Phase 1** (background + baskets) to establish your workflow, then proceed through phases 2-5 in order.

**Happy creating!** 🎨✨

---

**Quick Links**:
- [VISUAL_SPEC.md](VISUAL_SPEC.md) - Full specification
- [AI_GENERATION_PROMPTS.md](AI_GENERATION_PROMPTS.md) - Copy-paste prompts
- [ASSET_CREATION_CHECKLIST.md](ASSET_CREATION_CHECKLIST.md) - Task tracking
- [assets/README.md](../assets/README.md) - Folder structure
- [assets/COLOR_PALETTE.json](../assets/COLOR_PALETTE.json) - Import into Aseprite/Krita
