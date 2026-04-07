extends CanvasLayer

## Reactive HUD — connects to GameManager signals and updates labels.

@onready var level_label: Label = $TopBar/LevelLabel
@onready var points_label: Label = $TopBar/PointsLabel
@onready var progress_label: Label = $BottomBar/ProgressLabel
@onready var progress_bar: ProgressBar = $BottomBar/BasketProgressBar
@onready var tutorial_label: Label = $TutorialLabel

func _ready() -> void:
	GameManager.points_changed.connect(_on_points_changed)
	GameManager.level_changed.connect(_on_level_changed)
	GameManager.item_sorted_correct.connect(_on_item_sorted)
	GameManager.item_sorted_wrong.connect(_on_item_sorted_wrong)
	GameManager.bin_full.connect(_on_bin_full)
	_refresh()

func _refresh() -> void:
	_on_level_changed(GameManager.current_level)
	_on_points_changed(GameManager.player_points)

func show_tutorial(text: String) -> void:
	if tutorial_label:
		tutorial_label.text = text
		tutorial_label.visible = text != ""

func _on_points_changed(new_total: int) -> void:
	if points_label:
		points_label.text = "Points: %d" % new_total

func _on_level_changed(new_level: int) -> void:
	if level_label:
		level_label.text = "Level %d" % new_level
	_update_progress()

func _on_item_sorted(_item_id: String, _bin_id: String) -> void:
	_update_progress()

func _on_item_sorted_wrong(_item_id: String, _bin_id: String, _reason: String) -> void:
	pass  # FeedbackLabel handles the message

func _on_bin_full(_bin_id: String, _items: Array) -> void:
	_update_progress()

func _update_progress() -> void:
	# Sum all items across all bins for total sorted count
	var total := 0
	for bin_id in GameManager.bin_contents:
		total += GameManager.bin_contents[bin_id].size()
	var target := ProgressionManager.get_item_count(GameManager.current_level)
	if progress_bar:
		progress_bar.max_value = target
		progress_bar.value = total
	if progress_label:
		progress_label.text = "%d / %d" % [total, target]
