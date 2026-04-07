extends Area2D

## A sorting bin that accepts dragged ClothingItems based on current level rules.

signal item_accepted(item_id: String)
signal item_rejected(item_id: String, reason: String)
signal bin_became_full(bin_id: String)

@export var bin_id: String = ""

@onready var bin_sprite: ColorRect = $BinSprite
@onready var bin_label: Label = $LabelPanel/BinLabel
@onready var count_label: Label = $ItemCountLabel
@onready var collision_shape: CollisionShape2D = $CollisionShape

const MAX_ITEMS: int = 10

# Bin tint colors for placeholder art
const BIN_COLORS := {
	"bin_lights":   Color(0.96, 0.94, 0.91),
	"bin_darks":    Color(0.17, 0.20, 0.25),
	"bin_30":       Color(0.77, 0.87, 0.93),
	"bin_40":       Color(0.96, 0.82, 0.50),
	"bin_60":       Color(0.84, 0.40, 0.30),
	"bin_wool_delicate": Color(0.80, 0.75, 0.90),
	"bin_handwash_sink": Color(0.60, 0.85, 0.90),
}

func _ready() -> void:
	_update_display()
	_apply_placeholder_color()

func setup(data: Dictionary) -> void:
	bin_id = data.get("id", bin_id)
	if bin_label:
		bin_label.text = data.get("label", bin_id)
	_apply_placeholder_color()
	_update_display()

func _apply_placeholder_color() -> void:
	if bin_sprite:
		bin_sprite.color = BIN_COLORS.get(bin_id, Color(0.75, 0.72, 0.68))

## Called by DragDropController when an item is dropped over this bin.
func try_accept_item(item: Area2D) -> bool:
	var item_id_val: String = item.item_id
	var current_count: int = GameManager.get_bin_count(bin_id)
	if current_count >= MAX_ITEMS:
		item_rejected.emit(item_id_val, "Bin is already full!")
		return false

	var accepted := GameManager.sort_item(item_id_val, bin_id)
	if accepted:
		_update_display()
		item_accepted.emit(item_id_val)
		if GameManager.is_bin_full(bin_id):
			bin_became_full.emit(bin_id)
	else:
		item_rejected.emit(item_id_val, "Wrong bin!")
	return accepted

func highlight_wrong() -> void:
	if not bin_sprite:
		return
	var original_color := bin_sprite.color
	var tween := create_tween()
	tween.tween_property(bin_sprite, "color", Color(0.96, 0.27, 0.27), 0.1)
	tween.tween_property(bin_sprite, "color", original_color, 0.3)

func highlight_correct() -> void:
	if not bin_sprite:
		return
	var original_color := bin_sprite.color
	var tween := create_tween()
	tween.tween_property(bin_sprite, "color", Color(0.30, 0.76, 0.44), 0.1)
	tween.tween_property(bin_sprite, "color", original_color, 0.4)

func get_item_count() -> int:
	return GameManager.get_bin_count(bin_id)

func clear_bin() -> void:
	_update_display()

func _update_display() -> void:
	if count_label:
		var cnt := GameManager.get_bin_count(bin_id)
		count_label.text = "%d / %d" % [cnt, MAX_ITEMS]
