extends Node2D

## The wicker basket in the bottom-right that holds the incoming laundry pile.
## Spawns ClothingItem instances on demand from the level item queue.

signal basket_emptied()
signal item_spawned(item: Area2D)

@onready var spawn_point: Marker2D = $SpawnPoint

const ClothingItemScene := preload("res://scenes/components/clothing_item.tscn")

var _item_queue: Array = []
var _items_parent: Node2D = null  # set by GameScene to ClothingItems node

func _ready() -> void:
	pass

## Call this from GameScene when starting a level.
func load_level(level: int, items_parent: Node2D) -> void:
	_items_parent = items_parent
	_item_queue = ProgressionManager.build_item_queue(level)
	_item_queue.shuffle()

## Spawn the next item from the queue and return it (or null if empty).
func spawn_next_item() -> Area2D:
	if _item_queue.is_empty():
		basket_emptied.emit()
		return null

	var item_id: String = _item_queue.pop_front()
	var item_data: Dictionary = ClothingData.get_clothing(item_id)
	if item_data.is_empty():
		return spawn_next_item()  # skip unknown ids

	var item: Area2D = ClothingItemScene.instantiate()
	var spawn_pos: Vector2 = spawn_point.global_position if spawn_point else global_position
	item.global_position = spawn_pos
	item.setup(item_data)
	item.set_home(spawn_pos)

	if _items_parent:
		_items_parent.add_child(item)
	else:
		get_tree().current_scene.add_child(item)

	item_spawned.emit(item)
	return item

func get_remaining_count() -> int:
	return _item_queue.size()
