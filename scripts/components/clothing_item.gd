extends Area2D

## A draggable clothing item. Spawned at runtime by SourceBasket.

signal clicked(item: Area2D)
signal hover_enter(item: Area2D)
signal hover_exit(item: Area2D)

@export var item_id: String = ""
@export var draggable: bool = true

@onready var item_sprite: ColorRect = $ItemSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var highlight_rect: ColorRect = $HighlightRect

## Position to return to on bounce-back
var _home_position: Vector2 = Vector2.ZERO

## Item data loaded from ClothingData
var _item_data: Dictionary = {}

# Palette colors for placeholder art (color_group -> hex)
const COLOR_MAP := {
	"white":      Color(0.96, 0.94, 0.91),  # cream/off-white
	"cream":      Color(0.96, 0.94, 0.91),
	"light_gray": Color(0.85, 0.84, 0.82),
	"light_blue": Color(0.77, 0.87, 0.93),
	"light_pink": Color(0.96, 0.82, 0.84),
	"light_yellow":Color(0.98, 0.95, 0.75),
	"black":      Color(0.17, 0.20, 0.25),
	"dark_blue":  Color(0.18, 0.27, 0.43),
	"dark_gray":  Color(0.35, 0.34, 0.33),
	"dark_green": Color(0.18, 0.30, 0.22),
	"red":        Color(0.84, 0.25, 0.27),
	"navy":       Color(0.11, 0.17, 0.30),
}

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func setup(data: Dictionary) -> void:
	_item_data = data
	item_id = data.get("id", "")
	_home_position = global_position
	_apply_placeholder_color()

func _apply_placeholder_color() -> void:
	if not item_sprite:
		return
	var color_key: String = _item_data.get("color", "white")
	item_sprite.color = COLOR_MAP.get(color_key, Color(0.9, 0.9, 0.9))

func get_item_data() -> Dictionary:
	return _item_data

func set_home(pos: Vector2) -> void:
	_home_position = pos

func play_bounce_back() -> void:
	collision_shape.disabled = false
	z_index = 0
	var tween := create_tween()
	tween.tween_property(self, "global_position", _home_position, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)

func play_sort_success() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

func set_highlighted(on: bool) -> void:
	if highlight_rect:
		highlight_rect.visible = on

func start_drag() -> void:
	collision_shape.disabled = true
	z_index = 100
	set_highlighted(false)

func end_drag() -> void:
	collision_shape.disabled = false
	z_index = 0

func _on_mouse_entered() -> void:
	set_highlighted(true)
	hover_enter.emit(self)

func _on_mouse_exited() -> void:
	set_highlighted(false)
	hover_exit.emit(self)
