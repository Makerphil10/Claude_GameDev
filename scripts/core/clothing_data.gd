extends Node

## Loads and provides access to the clothing database (autoload).
## All sort validation routes through validate_sort_for_level().

var clothing_items: Dictionary = {}
var bins: Dictionary = {}
var level_configs: Dictionary = {}
var sort_rule_groups: Dictionary = {}

func _ready() -> void:
	load_data()

func load_data() -> void:
	var file_path := "res://data/clothing_db.json"
	if not ResourceLoader.exists(file_path):
		push_error("ClothingData: database not found at %s" % file_path)
		return
	var json := JSON.new()
	var err := json.parse(ResourceLoader.load_as_text(file_path))
	if err != OK:
		push_error("ClothingData: JSON parse error %d" % err)
		return
	var data: Dictionary = json.data
	sort_rule_groups = data.get("sort_rule_groups", {})
	_parse_clothing(data.get("clothing_items", []))
	_parse_bins(data.get("bins", []))
	_parse_level_configs(data.get("level_configs", []))
	print("ClothingData loaded: %d items, %d bins, %d levels" % [
		clothing_items.size(), bins.size(), level_configs.size()
	])

func _parse_clothing(items: Array) -> void:
	for item in items:
		clothing_items[item.id] = item

func _parse_bins(bin_list: Array) -> void:
	for b in bin_list:
		bins[b.id] = b

func _parse_level_configs(configs: Array) -> void:
	for cfg in configs:
		level_configs[cfg.level] = cfg

# --- Accessors ---

func get_clothing(item_id: String) -> Dictionary:
	return clothing_items.get(item_id, {})

func get_bin(bin_id: String) -> Dictionary:
	return bins.get(bin_id, {})

func get_level_config(level: int) -> Dictionary:
	# Return exact level config, or walk backwards to find the nearest lower one
	if level_configs.has(level):
		return level_configs[level]
	var keys: Array = level_configs.keys()
	keys.sort()
	var best: Dictionary = {}
	for k in keys:
		if k <= level:
			best = level_configs[k]
	return best

func get_items_for_level(level: int) -> Array:
	var cfg := get_level_config(level)
	var pool: Array = cfg.get("item_pool", [])
	var result: Array = []
	for id in pool:
		if clothing_items.has(id):
			result.append(clothing_items[id])
	return result

func get_bins_for_level(level: int) -> Array:
	var cfg := get_level_config(level)
	var active_ids: Array = cfg.get("active_bins", [])
	var result: Array = []
	for id in active_ids:
		if bins.has(id):
			result.append(bins[id])
	return result

func get_care_icons(item_id: String) -> Dictionary:
	var item := get_clothing(item_id)
	return item.get("care_icons", {})

func find_button_in_pocket(item_id: String) -> bool:
	var item := get_clothing(item_id)
	var chance: float = item.get("pocket_chance", 0.0)
	return randf() < chance

# --- Sort Validation ---

## Returns { "valid": bool, "reason": String, "rule_id": String }
## rule_id is used by the reference poster to highlight the relevant rule.
func validate_sort_for_level(item_id: String, bin_id: String, level: int) -> Dictionary:
	var item := get_clothing(item_id)
	var bin := get_bin(bin_id)

	if item.is_empty():
		return { "valid": false, "reason": "Unknown item.", "rule_id": "" }
	if bin.is_empty():
		return { "valid": false, "reason": "Unknown bin.", "rule_id": "" }

	var sort_rule: String = bin.get("sort_rule", "")

	match sort_rule:
		"color_group":
			return _validate_color_group(item, bin)
		"temperature":
			return _validate_temperature(item, bin)
		"fabric_wash_method":
			return _validate_fabric_wash(item, bin)
		_:
			return { "valid": false, "reason": "Unknown sort rule.", "rule_id": "" }

func _validate_color_group(item: Dictionary, bin: Dictionary) -> Dictionary:
	var accepts: Array = bin.get("accepts_color_groups", [])
	var item_group: String = item.get("color_group", "")
	if item_group in accepts:
		return { "valid": true, "reason": "", "rule_id": "" }
	var expected_group := accepts[0] if accepts.size() > 0 else "lights"
	return {
		"valid": false,
		"reason": "This is a %s item. Put it in the %s basket!" % [item_group, expected_group],
		"rule_id": "rule_color_group"
	}

func _validate_temperature(item: Dictionary, bin: Dictionary) -> Dictionary:
	var accepts: Array = bin.get("accepts_temperatures", [])
	var item_temp: int = item.get("temperature", 0)
	if item_temp in accepts:
		return { "valid": true, "reason": "", "rule_id": "" }
	var bin_temp := accepts[0] if accepts.size() > 0 else 0
	return {
		"valid": false,
		"reason": "This needs washing at %d°, not %d°." % [item_temp, bin_temp],
		"rule_id": "rule_temperature"
	}

func _validate_fabric_wash(item: Dictionary, bin: Dictionary) -> Dictionary:
	var accepts_fabrics: Array = bin.get("accepts_fabric_types", [])
	var accepts_method: String = bin.get("accepts_wash_method", "machine")
	var item_fabric: String = item.get("fabric_type", "")
	var item_method: String = item.get("wash_method", "machine")

	if item_method != accepts_method:
		if item_method == "hand_wash":
			return {
				"valid": false,
				"reason": "%s must be hand washed in the sink!" % item.get("name", "This item"),
				"rule_id": "rule_hand_wash"
			}
		return {
			"valid": false,
			"reason": "This goes in the machine, not the sink.",
			"rule_id": "rule_machine_wash"
		}

	if accepts_fabrics.size() > 0 and item_fabric not in accepts_fabrics:
		return {
			"valid": false,
			"reason": "%s fabric doesn't belong in the %s bin." % [item_fabric, bin.get("label", "this")],
			"rule_id": "rule_fabric_type"
		}

	return { "valid": true, "reason": "", "rule_id": "" }
