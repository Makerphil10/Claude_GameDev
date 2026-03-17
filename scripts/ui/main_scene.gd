extends Node

## Main scene controller

var game_manager: Node
var clothing_data: Node

func _ready() -> void:
	# Get references to managers
	game_manager = get_node("/root/Main/GameManager")
	clothing_data = get_node("/root/Main/ClothingData")

	print("Game started! Level: %d" % game_manager.current_level)
	print("Available baskets: %d" % clothing_data.get_all_baskets().size())

func _process(_delta: float) -> void:
	pass
