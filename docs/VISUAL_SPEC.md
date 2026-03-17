# Pixel Art Visual Specification
## Laundry Day Game

---

## 1. GLOBAL STYLE GUIDE

### Aesthetic
- **Genre**: Cozy, educational pixel art (similar to Stardew Valley / Animal Crossing vibes)
- **Perspective**: 3/4 isometric view (top-down angled)
- **Tone**: Warm, inviting, slightly rounded corners on shapes
- **Target Resolution**: 1280x720 (game viewport)

### Color Palette
```
Primary (Neutrals):
- Cream/Off-white:    #F5F1E8
- Light Beige:        #E8DCC8
- Warm Gray:          #C4B5A0
- Dark Brown:         #5D4E37

Secondary (Accents):
- Soft Blue:          #7DAAC1
- Laundry Purple:     #8B7BA8
- Soft Green:         #A8C68F
- Warm Orange:        #D4956E

Functional:
- Success Green:      #6BA86F
- Alert Red:          #D46464
- Warning Yellow:     #F4D35E
- Text Dark:          #2C2416
```

### Grid System
- **Base tile size**: 64×64 pixels
- **Asset grid snapping**: 16×16 (for finer detail)
- **Isometric offset**: Y-shift of 32px per row

---

## 2. ENVIRONMENT ASSETS

### 2.1 Laundry Room Background
**Dimensions**: 1280×720 pixels
**Concept**: Room foundation/environment layer ONLY (compositable background)

**Layers**:
- Background (walls, floor, lighting)
- Fixed furniture (shelves, racks, sink - minimal)
- **NO dynamic assets** (no washing machine, baskets, or clothing visible)

**Elements to Include**:
- Soft cream/beige walls with subtle texture
- Tiled floor (light gray, 64×64 tiles with perspective)
- Wooden shelves/hanging rack in background (optional)
- Simple counter/sink detail (optional)
- Window with warm lighting (optional)
- **Open foreground space** for asset placement

**Elements to EXCLUDE**:
- ✗ Washing machine (placed separately, 256×256px)
- ✗ Laundry baskets (placed separately, 96×96px each)
- ✗ Clothing items
- ✗ Clutter that blocks asset placement

**Note**: This is a compositable background layer. Other assets (baskets, machine, rack) will be placed on top of it at game runtime.

### 2.2 Laundry Baskets
**Base size**: 96×96 pixels
**Types**:
1. **Dirty clothes basket** - Cream/tan, full appearance
2. **Clean clothes basket** - White, fresh appearance
3. **Sorted basket** - Purple-tinted, organized
4. **Darks basket** - Dark gray, for dark fabrics

**Style**: Woven texture, slightly tilted isometric angle, rounded handles

---

## 3. CLOTHING ITEM ASSETS

### 3.1 Base Clothing Dimensions
- **Individual item (small)**: 48×48 pixels
- **Individual item (large)**: 64×64 pixels
- **Inventory slot**: 64×64 pixels
- **Basket view (stacked)**: 32×32 pixels

### 3.2 Clothing Types (5 Base Items)

#### Type 1: T-Shirt
- **Colors**: Red, Blue, Green, Purple, Gray (5 variants)
- **Details**: Simple front view, subtle wrinkles, rounded neckline
- **Style**: Casual, slightly slouchy

#### Type 2: Jeans
- **Colors**: Dark Blue, Light Blue, Black (3 variants)
- **Details**: Front view, two pockets, zipper detail, stitching
- **Style**: Classic denim

#### Type 3: Sweater/Hoodie
- **Colors**: Brown, Cream, Navy, Pink (4 variants)
- **Details**: Chunky knit texture, hood implied in side view, sleeves visible
- **Style**: Cozy, oversized

#### Type 4: Sock
- **Colors**: White, Black, Gray, Striped (4 variants)
- **Details**: Folded pair, ankle height
- **Style**: Simple, cute

#### Type 5: Underwear/Intimates
- **Colors**: White, Beige, Black (3 variants)
- **Details**: Simple silhouette, minimal detail
- **Style**: Clean, basic

### 3.3 Clothing States
- **Clean**: Bright, vibrant colors, no stains
- **Dirty**: Slightly muted, subtle stain marks
- **Wet**: Darker shade (20% opacity boost), water droplets
- **Wrinkled**: Wavy outlines, texture marks

---

## 4. UI & SYMBOL ASSETS

### 4.1 Care Label Icons
**Size**: 48×48 pixels (scalable to 32×32)

#### Icon Set:
1. **Wash Temperature**
   - Cold (snowflake symbol)
   - Warm (mild wave)
   - Hot (three wavy lines)

2. **Fabric Care**
   - Delicate (flower symbol)
   - Normal (circle)
   - Heavy duty (bold square)

3. **Drying**
   - Air dry (hanging line)
   - Tumble dry (circle with dot)
   - Do not dry (crossed circle)

4. **Bleach**
   - Bleach allowed (triangle)
   - No bleach (X triangle)

5. **Ironing**
   - Iron allowed (iron symbol)
   - No iron (X iron)

**Style**: Line-based, minimal, clear at both 48×48 and 32×32

### 4.2 UI Elements
**Button size**: 64×64 pixels
**Font**: Pixel font, 8px base height (for readability)

#### Button Types:
- Standard button (rounded rectangle, cream background)
- Hover state (slightly lighter, subtle shadow)
- Active state (darker border, slight inset)
- Disabled state (grayed out, 50% opacity)

#### Progress Indicators:
- Washing progress bar (80×16px)
- Rinsing bubble indicators (24×24px each)
- Spin cycle spinner (32×32px rotating)

### 4.3 Magnifying Glass (Inspection Tool)
**Size**: 96×96 pixels
- Circular glass (80×80px) with wooden handle
- Magnified view inside (zoomed 2x clothing detail)
- Soft shadow beneath

---

## 5. WASHING MACHINE ASSETS

### 5.1 Machine Body
**Dimensions**: 256×256 pixels
- Rounded rectangular shape
- Metal-gray body with subtle texture
- Clear circular door (front view, isometric angle)
- Control panel on top

### 5.2 Machine UI Elements
- **Dial knob**: 48×48px, rotatable
- **Mode buttons**: 40×40px each
- **Display screen**: 64×48px, dark screen, LED-style text
- **Detergent dispenser**: small drawer detail

### 5.3 Animation States
- **Idle**: Static, slight shine on door
- **Running**: Door glass slightly distorted/swirly
- **Spin cycle**: Drum interior visible, clothes spinning
- **Done**: Door slightly ajar, steam wisps

---

## 6. ANIMATION SPECIFICATIONS

### Clothing Movement
- **Gentle sway**: 2-3 pixel vertical bounce, 200ms cycle
- **Spin in basket**: Slow rotation over 5 seconds
- **Wet drip**: Small water droplet animation, 1s loop

### Machine Animation
- **Door opening/closing**: 8 frames, 300ms total
- **Clothes tumbling**: Looping rotation, varies per load
- **Steam wisps**: Particle effect rising from machine

### UI Animation
- **Button press**: 2-frame animation, 100ms
- **Progress fill**: Smooth linear fill over cycle time
- **Success feedback**: Brief glow effect, 400ms

---

## 7. ASSET ORGANIZATION

```
assets/
├── environment/
│   ├── laundry_room_bg.png (1280×720)
│   ├── baskets/
│   │   ├── basket_dirty.png (96×96)
│   │   ├── basket_clean.png (96×96)
│   │   ├── basket_sorted.png (96×96)
│   │   └── basket_darks.png (96×96)
│   └── washing_machine/ (256×256 base)
│       ├── machine_body.png
│       ├── machine_door_open.png
│       ├── machine_door_closed.png
│       └── machine_running.png
├── clothing/
│   ├── tshirt_*.png (64×64)
│   ├── jeans_*.png (64×64)
│   ├── sweater_*.png (64×64)
│   ├── socks_*.png (64×64)
│   └── underwear_*.png (64×64)
├── ui/
│   ├── care_icons/
│   │   ├── temp_cold.png (48×48)
│   │   ├── temp_warm.png (48×48)
│   │   └── ... (others)
│   ├── buttons/
│   │   ├── btn_standard.png (64×64)
│   │   └── btn_states.png (192×64 - 3 states)
│   ├── progress_bar.png (80×16)
│   └── magnifying_glass.png (96×96)
└── animations/
    ├── door_open.aseprite (8 frames)
    ├── clothes_spin.aseprite (16 frames)
    └── steam_wisps.aseprite (12 frames)
```

---

## 8. GENERATION GUIDELINES FOR AI

### Prompt Structure
- Always specify: "pixel art style, 64×64 grid, isometric 3/4 view"
- Reference color palette hex codes directly
- Specify "no gradients, use flat colors" for pixel art consistency
- Request "rounded corners, cute aesthetic"

### Quality Standards
- **Consistency**: All assets use same line weight (~2 pixels for outlines)
- **Clarity**: Assets readable at 48×48 and larger
- **Alignment**: Assets snap to 16×16 grid
- **Symmetry**: Clothing items balanced, baskets even-sided

---

## 9. NOTES FOR IMPLEMENTATION

1. All PNGs should have **transparent backgrounds** (RGBA)
2. Use **no anti-aliasing** for crisp pixel edges
3. Color palette should be **indexed/limited** to palette above
4. Test assets at 2x and 4x zoom for clarity
5. Prepare Aseprite/Krita projects with visible grid (16×16)
6. Export at native resolution, NO scaling
