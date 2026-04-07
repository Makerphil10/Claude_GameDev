extends Node2D

## Root controller for the main gameplay scene.
## Wires up all components and manages the level lifecycle.

@onready var source_basket: Node2D = $World/SourceBasket
@onready var sorting_bins_node: Node2D = $World/SortingBins
@onready var clothing_items_node: Node2D = $World/ClothingItems
@onready var drag_controller: Node = $DragDropController
@onready var hud: CanvasLayer = $HUD
@onready var feedback_label: Node2D = $FeedbackLayer/FeedbackLabel
@onready var inspection_popup: CanvasLayer = $InspectionPopup
@onready var reference_poster: Node2D = $Background/ReferencePoster
@onready var cow_mascot: Node2D = $World/CowMascot

const SortingBinScene := preload("res://scenes/components/sorting_bin.tscn")

var _active_bins: Array = []

func _ready() -> void:
	GameManager.wash_cycle_complete.connect(_on_wash_complete)
	GameManager.level_changed.connect(_on_level_changed)
	GameManager.item_sorted_wrong.connect(_on_wrong_sort)

	drag_controller.item_inspect_requested.connect(_on_inspect_requested)
	inspection_popup.popup_closed.connect(_on_inspection_closed)

	_start_level(GameManager.current_level)

func _start_level(level: int) -> void:
	# Clear previous state
	for child in sorting_bins_node.get_children():
		child.queue_free()
	for child in clothing_items_node.get_children():
		child.queue_free()
	_active_bins.clear()

	# Spawn bins for this level
	var bin_data_list := ClothingData.get_bins_for_level(level)
	var bin_positions := _get_bin_positions(bin_data_list.size())
	for i in bin_data_list.size():
		var bin: Area2D = SortingBinScene.instantiate()
		sorting_bins_node.add_child(bin)
		bin.global_position = bin_positions[i]
		bin.setup(bin_data_list[i])
		_active_bins.append(bin)

	drag_controller.register_bins(_active_bins)
	source_basket.load_level(level, clothing_items_node)
	source_basket.spawn_next_item()

	var tutorial := ProgressionManager.get_tutorial_text(level)
	if hud and hud.has_method("show_tutorial"):
		hud.show_tutorial(tutorial)

## Evenly-spaced bin positions along the shelf row.
func _get_bin_positions(count: int) -> Array:
	var positions: Array = []
	var shelf_y := 260.0
	var start_x := 200.0
	var spacing := 180.0
	for i in count:
		positions.append(Vector2(start_x + i * spacing, shelf_y))
	return positions

func _on_inspect_requested(item: Area2D) -> void:
	var data := item.get_item_data()
	if data.is_empty():
		return
	drag_controller.inspection_open = true
	inspection_popup.show_item(data)

func _on_inspection_closed() -> void:
	drag_controller.inspection_open = false

func _on_wrong_sort(_item_id: String, _bin_id: String, _reason: String) -> void:
	# Ask ClothingData for the rule_id that caused the rejection, then glow it on the poster
	# rule_id was part of the validate_sort_for_level result; we re-run to get it
	var result := ClothingData.validate_sort_for_level(
		_item_id, _bin_id, GameManager.current_level
	)
	var rule_id: String = result.get("rule_id", "")
	if rule_id != "" and reference_poster:
		reference_poster.highlight_rule(rule_id)
	_shake_cow()

func _shake_cow() -> void:
	if not cow_mascot:
		return
	var original_x := cow_mascot.position.x
	var tween := create_tween()
	tween.tween_property(cow_mascot, "position:x", original_x + 6.0, 0.07)
	tween.tween_property(cow_mascot, "position:x", original_x - 6.0, 0.07)
	tween.tween_property(cow_mascot, "position:x", original_x + 4.0, 0.06)
	tween.tween_property(cow_mascot, "position:x", original_x - 4.0, 0.06)
	tween.tween_property(cow_mascot, "position:x", original_x, 0.05)

func _on_wash_complete(bin_id: String) -> void:
	for bin in _active_bins:
		if bin.bin_id == bin_id:
			bin.clear_bin()
			break
	if source_basket.get_remaining_count() > 0:
		source_basket.spawn_next_item()

func _on_level_changed(new_level: int) -> void:
	_start_level(new_level)
