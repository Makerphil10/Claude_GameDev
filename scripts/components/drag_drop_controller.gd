extends Node

## Handles all mouse-based drag-and-drop for ClothingItems.
## Lives as a child of GameScene. Routes drop results through GameManager signals.
##
## IMPORTANT: Uses _unhandled_input + manual mouse tracking — NOT Godot's
## built-in drag_data system (which is designed for UI Control nodes, not Area2D).

signal drag_started(item: Area2D)
signal drag_ended(item: Area2D, accepted: bool)

var _dragged_item: Area2D = null
var _drag_offset: Vector2 = Vector2.ZERO

## Filled by GameScene so we can test drop targets on release
var _bins: Array = []

## Set by GameScene — the physics space for overlap queries
var _space_state: PhysicsDirectSpaceState2D = null

func _ready() -> void:
	pass

func register_bins(bins: Array) -> void:
	_bins = bins

## Called every frame while dragging to move the item with the mouse.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		if mb.button_index == MOUSE_BUTTON_LEFT:
			if mb.pressed:
				_try_start_drag(mb.global_position)
			else:
				_end_drag(mb.global_position)

	elif event is InputEventMouseMotion and _dragged_item:
		_dragged_item.global_position = event.global_position + _drag_offset

func _try_start_drag(mouse_pos: Vector2) -> void:
	# Find the topmost ClothingItem under the cursor
	var item := _find_item_at(mouse_pos)
	if item and item.draggable:
		_dragged_item = item
		_drag_offset = item.global_position - mouse_pos
		item.start_drag()
		drag_started.emit(item)
		get_viewport().set_input_as_handled()

func _end_drag(mouse_pos: Vector2) -> void:
	if not _dragged_item:
		return
	var item := _dragged_item
	_dragged_item = null
	item.end_drag()

	# Find which bin (if any) overlaps the drop position
	var target_bin := _find_bin_at(item.global_position)

	if target_bin:
		var accepted := target_bin.try_accept_item(item)
		if accepted:
			item.play_sort_success()
			target_bin.highlight_correct()
			item.queue_free()
		else:
			item.play_bounce_back()
			target_bin.highlight_wrong()
		drag_ended.emit(item, accepted)
	else:
		# Dropped in empty space — bounce back
		item.play_bounce_back()
		drag_ended.emit(item, false)

## Scans registered bins for the one whose Area2D overlaps the given position.
## Uses a small overlap check rather than point-in-rect for accuracy.
func _find_bin_at(pos: Vector2) -> Area2D:
	for bin in _bins:
		if not is_instance_valid(bin):
			continue
		# Use the bin's CollisionShape rect to test containment
		var shape_node: CollisionShape2D = bin.get_node_or_null("CollisionShape")
		if not shape_node:
			continue
		var shape := shape_node.shape
		if shape is RectangleShape2D:
			var half := shape.size / 2.0
			var local_pos := bin.to_local(pos)
			if abs(local_pos.x) <= half.x and abs(local_pos.y) <= half.y:
				return bin
	return null

## Returns the topmost ClothingItem Area2D that contains the given position.
func _find_item_at(pos: Vector2) -> Area2D:
	var best: Area2D = null
	var best_z := -999999
	# Iterate all children of the ClothingItems container
	var items_node := get_tree().current_scene.get_node_or_null("World/ClothingItems")
	if not items_node:
		return null
	for child in items_node.get_children():
		if not child is Area2D:
			continue
		var shape_node: CollisionShape2D = child.get_node_or_null("CollisionShape")
		if not shape_node:
			continue
		var shape := shape_node.shape
		if shape is RectangleShape2D:
			var half := shape.size / 2.0
			var local_pos := child.to_local(pos)
			if abs(local_pos.x) <= half.x and abs(local_pos.y) <= half.y:
				if child.z_index >= best_z:
					best = child
					best_z = child.z_index
	return best
