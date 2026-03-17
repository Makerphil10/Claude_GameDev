extends Node

## Loads and manages clothing database

var clothing_items: Dictionary = {}
var baskets: Dictionary = {}

func _ready() -> void:
	load_data()

func load_data() -> void:
	var file_path = "res://data/clothing_db.json"
	if ResourceLoader.exists(file_path):
		var json = JSON.new()
		var error = json.parse(ResourceLoader.load_as_text(file_path))
		if error == OK:
			var data = json.data
			_parse_clothing(data.get("clothing_items", []))
			_parse_baskets(data.get("baskets", []))
			print("Clothing database loaded: %d items, %d baskets" % [clothing_items.size(), baskets.size()])
		else:
			print("Error parsing JSON: ", error)
	else:
		print("Clothing database not found: ", file_path)

func _parse_clothing(items: Array) -> void:
	for item in items:
		clothing_items[item.id] = item

func _parse_baskets(basket_list: Array) -> void:
	for basket in basket_list:
		baskets[basket.id] = basket

func get_clothing(item_id: String) -> Dictionary:
	return clothing_items.get(item_id, {})

func get_basket(basket_id: String) -> Dictionary:
	return baskets.get(basket_id, {})

func get_all_baskets() -> Array:
	return baskets.values()

func validate_sort(item_id: String, basket_id: String) -> bool:
	var item = get_clothing(item_id)
	var basket = get_basket(basket_id)

	if item.is_empty() or basket.is_empty():
		return false

	# Check temperature
	if item.temperature != basket.temperature:
		return false

	# Check fabric type
	if item.fabric_type not in basket.fabric_types:
		return false

	# Check color (basic - would be more complex in full game)
	# For now, just validate temperature + fabric

	return true
