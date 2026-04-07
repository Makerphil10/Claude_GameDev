extends Node

## Handles all mouse-based drag-and-drop for ClothingItems.
## Also detects hover (0.5s hold without drag) to trigger item inspection.
## Lives as a child of GameScene. Routes drop results through GameManager signals.
##
## IMPORTANT: Uses _unhandled_input + manual mouse tracking — NOT Godot's
## built-in drag_data system (which is designed for UI Control nodes, not Area2D).

signal drag_started(item: Area2D)
signal drag_ended(item: Area2D, accepted: bool)
signal item_inspect_requested(item: Area2D)

const HOVER_INSPECT_TIME := 0.5  # seconds of holding before inspection triggers
const DRAG_THRESHOLD := 6.0      # pixels moved before a hold becomes a drag

var _dragged_item: Area2D = null
var _drag_offset: Vector2 = Vector2.ZERO

## Filled by GameScene so we can test drop targets on release
var _bins: Array = []

## Hover / inspect state
var _hover_item: Area2D = null
var _hover_press_pos: Vector2 = Vector2.ZERO
var _hover_timer: float = 0.0
var _is_holding: bool = false   # mouse down but not yet dragging

## Set true while InspectionPopup is open — blocks new drags
var inspection_open: bool = false

func _ready() -> void:
	pass

func register_bins(bins: Array) -> void:
	_bins = bins

func _process(delta: float) -> void:
	if _is_holding and not _dragged_item and not inspection_open:
		_hover_timer += delta
		if _hover_timer >= HOVER_INSPECT_TIME and _hover_item:
			_is_holding = false
			_hover_timer = 0.0
			item_inspect_requested.emit(_hover_item)

func _unhandled_input(event: InputEvent) -> void:
	if inspection_open:
		return

	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		if mb.button_index == MOUSE_BUTTON_LEFT:
			if mb.pressed:
				_on_mouse_pressed(mb.global_position)
			else:
				_on_mouse_released(mb.global_position)

	elif event is InputEventMouseMotion:
		if _dragged_item:
			_dragged_item.global_position = event.global_position + _drag_offset
		elif _is_holding and _hover_item:
			# Cancel inspect timer if mouse moves too far
			if event.global_position.distance_to(_hover_press_pos) > DRAG_THRESHOLD:
				_start_drag(_hover_item, _hover_press_pos)
				_is_holding = false
				_hover_timer = 0.0

func _on_mouse_pressed(mouse_pos: Vector2) -> void:
	var item := _find_item_at(mouse_pos)
	if item and item.draggable:
		_hover_item = item
		_hover_press_pos = mouse_pos
		_hover_timer = 0.0
		_is_holding = true
		get_viewport().set_input_as_handled()

func _on_mouse_released(mouse_pos: Vector2) -> void:
	_is_holding = false
	_hover_timer = 0.0
	if _dragged_item:
		_end_drag(mouse_pos)
	_hover_item = null

func _start_drag(item: Area2D, press_pos: Vector2) -> void:
	_dragged_item = item
	_drag_offset = item.global_position - press_pos
	item.start_drag()
	drag_started.emit(item)

func _end_drag(_mouse_pos: Vector2) -> void:
	if not _dragged_item:
		return
	var item := _dragged_item
	_dragged_item = null
	item.end_drag()

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
		item.play_bounce_back()
		drag_ended.emit(item, false)

## Scans registered bins for the one whose CollisionShape rect contains pos.
func _find_bin_at(pos: Vector2) -> Area2D:
	for bin in _bins:
		if not is_instance_valid(bin):
			continue
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

## Returns the topmost ClothingItem Area2D that contains pos.
func _find_item_at(pos: Vector2) -> Area2D:
	var best: Area2D = null
	var best_z := -999999
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
