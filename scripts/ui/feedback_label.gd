extends Node2D

## Displays transient feedback messages (wrong sort, success, etc.)
## Messages fade in upward, hold briefly, then fade out.

@onready var label: Label = $Label

var _queue: Array = []
var _busy: bool = false

func _ready() -> void:
	GameManager.item_sorted_wrong.connect(_on_wrong_sort)
	GameManager.bin_full.connect(_on_bin_full)
	if label:
		label.modulate.a = 0.0

func show_message(text: String, color: Color = Color.WHITE, duration: float = 1.5) -> void:
	_queue.append({ "text": text, "color": color, "duration": duration })
	if not _busy:
		_show_next()

func _show_next() -> void:
	if _queue.is_empty():
		_busy = false
		return
	_busy = true
	var msg: Dictionary = _queue.pop_front()
	if not label:
		_busy = false
		return
	label.text = msg.text
	label.add_theme_color_override("font_color", msg.color)
	label.modulate.a = 0.0

	var start_y := 0.0
	var end_y := -40.0
	label.position.y = start_y

	var tween := create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.2)
	tween.parallel().tween_property(label, "position:y", end_y, 0.4)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_interval(msg.duration)
	tween.tween_property(label, "modulate:a", 0.0, 0.3)
	tween.tween_callback(_show_next)

func _on_wrong_sort(_item_id: String, _bin_id: String, reason: String) -> void:
	show_message(reason, Color(0.96, 0.27, 0.27))

func _on_bin_full(bin_id: String, _items: Array) -> void:
	var bin_data := ClothingData.get_bin(bin_id)
	var label_text: String = bin_data.get("label", bin_id)
	show_message("%s bin is full! Drag it to the machine." % label_text, Color(0.30, 0.76, 0.44))
