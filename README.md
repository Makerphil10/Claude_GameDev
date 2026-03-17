# Laundry Sorting Game

A cozy, educational pixel art game for kids to learn proper laundry sorting and washing techniques.

## Vision

**Core Loop:**
- Drag & drop clothing items from input basket
- Inspect care labels (hover → magnifier zoom)
- Sort into correct basket (color + fabric + temperature)
- Wrong sort = rejection, item bounces back
- Fill basket with 10 items → trigger wash cycle mini-game
- Wash cycle: set temperature, detergent, spin speed, cycle type
- Earn "style points" (coins) for correct sorting
- Post-MVP: shop system for cosmetic + gameplay upgrades

## Scope - MVP

**Target:** 1-2 levels, fully playable prototype
- 3 laundry baskets (different colors/fabrics/temps)
- 5-10 clothing item types (simple)
- Basic care label symbols
- Simple wash cycle (30°, auto spin only)
- No upgrades/shop in MVP
- Cozy, no time pressure, no fail states

## Tech Stack

- **Engine:** Godot 4.6
- **Language:** GDScript
- **Platform:** PC (web export later)
- **Art:** Pixel art isometric (hand-created)
- **Resolution:** 1024x768

## Project Structure

```
/
├── scenes/              # .tscn scene files
│   ├── main.tscn       # Main level/game scene
│   ├── ui/             # UI scenes
│   └── items/          # Item/clothing scenes
├── scripts/            # .gd GDScript files
│   ├── core/           # Core game logic
│   ├── ui/             # UI controllers
│   └── items/          # Item behaviors
├── assets/
│   ├── sprites/        # Pixel art sprites
│   ├── audio/          # SFX & music
│   └── fonts/          # Custom fonts
├── data/               # Game data (JSON/CSV)
│   └── clothing_db.json # Clothing items, properties
└── project.godot       # Godot project config
```

## MVP Development Plan

### Phase 1: Foundation (Setup)
- [x] Initialize Godot 4.6 project
- [ ] Create basic scenes & scripts structure
- [ ] Implement drag-drop system
- [ ] Create data models: Clothing items, Baskets, Care labels

### Phase 2: Core Gameplay
- [ ] Sorting basket scene with 3 sample baskets
- [ ] Clothing item spawning & drag-drop
- [ ] Collision/rejection logic (wrong sort)
- [ ] Inspection UI (hover magnifier)
- [ ] Care label reference poster

### Phase 3: Wash Cycle
- [ ] Washing machine scene & UI
- [ ] Temperature dial, detergent slider
- [ ] Simple cycle logic (30° only for MVP)
- [ ] Animation/feedback on completion

### Phase 4: Polish & MVP
- [ ] Points/scoring system
- [ ] Simple UI feedback (tooltips, animations)
- [ ] Audio (placeholder or simple SFX)
- [ ] Test with sample pixel art

## Art Direction (Reference)

- **Style:** Cozy isometric pixel art (stylized, not strict grid)
- **Palette:** Warm, soft colors (beiges, creams, soft browns, blues)
- **Resolution:** ~64px grid cells, sprites 32-160px
- **Aesthetic:** Cute, kid-friendly, lived-in laundry room

## Notes

- Keep complexity low for MVP — expand after playable prototype
- No time pressure or fail states (educational, cozy)
- Focus on clear visual/audio feedback for sorting
- Placeholder art OK for now, replace with proper pixel art later
