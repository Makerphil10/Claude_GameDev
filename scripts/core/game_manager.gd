extends Node

## Game state manager and singleton

var current_level: int = 1
var player_points: int = 0
var current_basket_items: Array = []
var sorted_items: int = 0

func _ready() -> void:
	pass

func add_points(amount: int) -> void:
	player_points += amount
	print("Points: %d" % player_points)

func add_sorted_item() -> void:
	sorted_items += 1
	if sorted_items >= 10:
		trigger_wash_cycle()

func trigger_wash_cycle() -> void:
	print("Basket full! Triggering wash cycle...")
	# TODO: Transition to wash machine scene
	sorted_items = 0

func is_clothing_correct(item: Dictionary, basket_id: String) -> bool:
	# TODO: Validate if item goes in basket
	return true
