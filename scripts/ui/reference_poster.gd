extends Node2D

## The laundry-symbol reference poster on the back wall.
## Shows the legend of all care symbols used in the current level.
## Glows the relevant rule row when the player makes a wrong sort.

signal poster_clicked()

@onready var poster_bg: ColorRect = $PosterBackground
@onready var title_label: Label = $TitleLabel
@onready var rules_container: VBoxContainer = $RulesContainer

# Maps rule_id (from validate_sort_for_level) to the row node
var _rule_rows: Dictionary = {}

# Laundry symbol rules displayed on the poster
const POSTER_RULES := [
	{
		"rule_id": "rule_color_group",
		"symbol": "◑",
		"text": "Light colors and dark colors apart!",
	},
	{
		"rule_id": "rule_temperature",
		"symbol": "〜",
		"text": "Number in tub = max wash temp",
	},
	{
		"rule_id": "rule_hand_wash",
		"symbol": "✋",
		"text": "Hand symbol = hand wash only, use the sink!",
	},
	{
		"rule_id": "rule_machine_wash",
		"symbol": "⊡",
		"text": "Tub symbol = machine wash OK",
	},
	{
		"rule_id": "rule_fabric_type",
		"symbol": "✦",
		"text": "Check fabric: wool, silk, cotton, denim",
	},
]

func _ready() -> void:
	GameManager.item_sorted_wrong.connect(_on_wrong_sort)
	_build_poster()
	if poster_bg:
		poster_bg.gui_input.connect(_on_bg_input)

func _build_poster() -> void:
	if not rules_container:
		return
	for child in rules_container.get_children():
		child.queue_free()
	_rule_rows.clear()

	for rule in POSTER_RULES:
		var row := _make_rule_row(rule)
		rules_container.add_child(row)
		_rule_rows[rule.rule_id] = row

## Flashes the matching rule row in warning yellow for 2 seconds.
func highlight_rule(rule_id: String) -> void:
	var row: Node = _rule_rows.get(rule_id, null)
	if not row:
		return
	var bg: ColorRect = row.get_node_or_null("RowBg")
	if not bg:
		return
	var original := bg.color
	var tween := create_tween()
	tween.tween_property(bg, "color", Color(0.95, 0.83, 0.24), 0.15)
	tween.tween_interval(1.5)
	tween.tween_property(bg, "color", original, 0.35)

func _make_rule_row(rule: Dictionary) -> Control:
	var container := Control.new()
	container.custom_minimum_size = Vector2(0, 28)

	var row_bg := ColorRect.new()
	row_bg.name = "RowBg"
	row_bg.color = Color(0.96, 0.94, 0.88, 0.0)  # transparent by default
	row_bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	container.add_child(row_bg)

	var hbox := HBoxContainer.new()
	hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	container.add_child(hbox)

	var symbol_label := Label.new()
	symbol_label.text = rule.get("symbol", "?")
	symbol_label.custom_minimum_size = Vector2(24, 0)
	symbol_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hbox.add_child(symbol_label)

	var text_label := Label.new()
	text_label.text = rule.get("text", "")
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_label.theme_override_font_sizes = {}  # will use default
	hbox.add_child(text_label)

	return container

func _on_wrong_sort(_item_id: String, _bin_id: String, _reason: String) -> void:
	# GameScene connects item_sorted_wrong -> highlight_rule via rule_id from signal
	pass

func _on_bg_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		poster_clicked.emit()
