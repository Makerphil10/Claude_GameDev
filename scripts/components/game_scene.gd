extends Node2D

## Root controller for the main gameplay scene.
## Wires up all components and manages the level lifecycle.

@onready var source_basket: Node2D = $World/SourceBasket
@onready var sorting_bins_node: Node2D = $World/SortingBins
@onready var clothing_items_node: Node2D = $World/ClothingItems
@onready var drag_controller: Node = $DragDropController
@onready var hud: CanvasLayer = $HUD
@onready var feedback_layer: Node2D = $FeedbackLayer/FeedbackLabel

const SortingBinScene := preload("res://scenes/components/sorting_bin.tscn")

var _active_bins: Array = []

func _ready() -> void:
	GameManager.wash_cycle_complete.connect(_on_wash_complete)
	GameManager.level_changed.connect(_on_level_changed)
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

	# Register bins with drag controller
	drag_controller.register_bins(_active_bins)

	# Load item queue into source basket
	source_basket.load_level(level, clothing_items_node)

	# Spawn first item
	source_basket.spawn_next_item()

	# Show tutorial hint
	var tutorial := ProgressionManager.get_tutorial_text(level)
	if hud and hud.has_method("show_tutorial"):
		hud.show_tutorial(tutorial)

## Calculate evenly-spaced positions for bins along the shelf area.
func _get_bin_positions(count: int) -> Array:
	var positions: Array = []
	var shelf_y := 260.0
	var start_x := 200.0
	var spacing := 180.0
	for i in count:
		positions.append(Vector2(start_x + i * spacing, shelf_y))
	return positions

func _on_wash_complete(bin_id: String) -> void:
	# Find the bin and clear its display
	for bin in _active_bins:
		if bin.bin_id == bin_id:
			bin.clear_bin()
			break
	# Spawn more items if the basket still has some
	if source_basket.get_remaining_count() > 0:
		source_basket.spawn_next_item()

func _on_level_changed(new_level: int) -> void:
	_start_level(new_level)
