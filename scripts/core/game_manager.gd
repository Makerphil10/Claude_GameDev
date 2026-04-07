extends Node

## Central event bus and game state singleton (autoload).
## All gameplay systems communicate through this node's signals.

# --- Signals ---
signal item_sorted_correct(item_id: String, bin_id: String)
signal item_sorted_wrong(item_id: String, bin_id: String, reason: String)
signal bin_full(bin_id: String, items: Array)
signal wash_cycle_started(bin_id: String)
signal wash_cycle_complete(bin_id: String)
signal level_changed(new_level: int)
signal points_changed(new_total: int)
signal buttons_changed(new_total: int)
signal phase_changed(new_phase: String)  # "sorting" | "washing"

# --- State ---
var current_level: int = 1
var player_points: int = 0
var buttons_currency: int = 0
var current_phase: String = "sorting"

## Maps bin_id -> Array of item_ids currently sorted into it
var bin_contents: Dictionary = {}

const ITEMS_PER_BIN: int = 10

# --- Public API ---

func sort_item(item_id: String, bin_id: String) -> bool:
	var result = ClothingData.validate_sort_for_level(item_id, bin_id, current_level)
	if result.valid:
		if not bin_contents.has(bin_id):
			bin_contents[bin_id] = []
		bin_contents[bin_id].append(item_id)
		add_points(ProgressionManager.get_points_per_correct(current_level))
		item_sorted_correct.emit(item_id, bin_id)
		if bin_contents[bin_id].size() >= ITEMS_PER_BIN:
			bin_full.emit(bin_id, bin_contents[bin_id].duplicate())
		return true
	else:
		add_points(ProgressionManager.get_points_per_wrong(current_level))
		item_sorted_wrong.emit(item_id, bin_id, result.reason)
		return false

func start_wash(bin_id: String) -> void:
	current_phase = "washing"
	phase_changed.emit(current_phase)
	wash_cycle_started.emit(bin_id)

func complete_wash(bin_id: String) -> void:
	bin_contents.erase(bin_id)
	current_phase = "sorting"
	phase_changed.emit(current_phase)
	wash_cycle_complete.emit(bin_id)

func add_points(amount: int) -> void:
	player_points = maxi(0, player_points + amount)
	points_changed.emit(player_points)

func add_buttons(amount: int) -> void:
	buttons_currency += amount
	buttons_changed.emit(buttons_currency)

func advance_level() -> void:
	current_level += 1
	bin_contents.clear()
	level_changed.emit(current_level)

func get_bin_count(bin_id: String) -> int:
	return bin_contents.get(bin_id, []).size()

func is_bin_full(bin_id: String) -> bool:
	return get_bin_count(bin_id) >= ITEMS_PER_BIN
