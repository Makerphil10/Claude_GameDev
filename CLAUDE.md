# Claude Code Configuration

## Project: Cozy Laundry Sort

A cozy, educational pixel art game built with Godot 4.6 (GDScript), teaching kids proper laundry sorting and washing techniques.

## Installed Skills

### UI/UX Pro Max (`/ui-ux-pro-max`)

Installed via `uipro-cli`. Provides AI-powered UI/UX design guidance including:
- Landing page and product UI generation
- Design system recommendations (colors, typography, icons)
- Framework-specific guidance (React, Next.js, Vue, Svelte, Flutter, SwiftUI, etc.)
- UX guidelines and web interface patterns

**Usage:** Invoke with `/ui-ux-pro-max` in Claude Code sessions.

**Installed:** `.claude/skills/ui-ux-pro-max/`

**To update:** `uipro update --ai claude`

## Development Notes

- Engine: Godot 4.6 / GDScript
- Main scene: `scenes/game_scene.tscn`
- Game data: `data/clothing_db.json`
- Asset specs: `docs/VISUAL_SPEC.md`
- Autoloads: `GameManager`, `ClothingData`, `ProgressionManager`
