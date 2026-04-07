extends Node

## Manages level progression, rules, and item pools (autoload).

signal rules_changed(active_rules: Dictionary)

func get_level_config(level: int) -> Dictionary:
	return ClothingData.get_level_config(level)

func get_sort_rule(level: int) -> String:
	return get_level_config(level).get("sort_rule", "color_group")

func get_active_bins(level: int) -> Array:
	return ClothingData.get_bins_for_level(level)

func get_item_pool(level: int) -> Array:
	return ClothingData.get_items_for_level(level)

func get_item_count(level: int) -> int:
	return get_level_config(level).get("item_count", 8)

func get_tutorial_text(level: int) -> String:
	return get_level_config(level).get("tutorial_text", "")

func get_level_title(level: int) -> String:
	return get_level_config(level).get("title", "Level %d" % level)

func get_points_per_correct(level: int) -> int:
	return get_level_config(level).get("points_per_correct", 10)

func get_points_per_wrong(level: int) -> int:
	return get_level_config(level).get("points_per_wrong", -2)

## Build a shuffled queue of item_ids for the level, repeated to fill item_count.
func build_item_queue(level: int) -> Array:
	var pool := get_item_pool(level)
	var count := get_item_count(level)
	if pool.is_empty():
		return []
	var queue: Array = []
	# Fill queue by cycling through pool until we reach item_count
	var idx := 0
	while queue.size() < count:
		queue.append(pool[idx % pool.size()].id)
		idx += 1
	queue.shuffle()
	return queue
