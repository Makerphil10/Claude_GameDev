extends CanvasLayer

## Inspection popup — shown when the player hovers 0.5s over a ClothingItem.
## Displays a zoomed view of the item plus all its care tag icons.

signal popup_closed()

@onready var dim_bg: ColorRect = $DimBackground
@onready var panel: PanelContainer = $PopupPanel
@onready var item_name_label: Label = $PopupPanel/VBox/ItemNameLabel
@onready var description_label: Label = $PopupPanel/VBox/DescriptionLabel
@onready var item_color_rect: ColorRect = $PopupPanel/VBox/ItemZoom
@onready var care_tag_container: HBoxContainer = $PopupPanel/VBox/CareTagContainer
@onready var close_button: Button = $PopupPanel/VBox/CloseButton

var _is_open: bool = false

# Care icon labels (placeholder text until real sprites are added)
const CARE_ICON_LABELS := {
	"temp_cold":      "30°C",
	"temp_warm":      "40°C",
	"temp_hot":       "60°C",
	"fabric_normal":  "Cotton",
	"fabric_heavy":   "Heavy",
	"fabric_delicate":"Delicate",
	"fabric_synthetic":"Synthetic",
	"dry_tumble":     "Tumble OK",
	"dry_air":        "Air Dry",
	"bleach_yes":     "Bleach OK",
	"bleach_no":      "No Bleach",
	"iron_yes":       "Iron OK",
	"iron_no":        "No Iron",
}

const CARE_ICON_COLORS := {
	"temp_cold":       Color(0.77, 0.87, 0.93),
	"temp_warm":       Color(0.98, 0.82, 0.50),
	"temp_hot":        Color(0.84, 0.40, 0.30),
	"fabric_delicate": Color(0.80, 0.75, 0.90),
	"dry_air":         Color(0.70, 0.90, 0.80),
	"bleach_no":       Color(0.96, 0.27, 0.27),
	"iron_no":         Color(0.96, 0.27, 0.27),
}

func _ready() -> void:
	visible = false
	if close_button:
		close_button.pressed.connect(close)

func show_item(item_data: Dictionary) -> void:
	if _is_open:
		return
	_is_open = true

	# Populate text
	if item_name_label:
		item_name_label.text = item_data.get("name", "")
	if description_label:
		description_label.text = item_data.get("description", "")

	# Tint the zoom rect to match the item's color
	if item_color_rect:
		var color_key: String = item_data.get("color", "white")
		item_color_rect.color = _color_for_key(color_key)

	# Build care tag chips
	_populate_care_tags(item_data.get("care_icons", {}))

	# Show with tween-in
	visible = true
	if panel:
		panel.modulate.a = 0.0
		panel.scale = Vector2(0.85, 0.85)
		var tween := create_tween()
		tween.set_parallel(true)
		tween.tween_property(panel, "modulate:a", 1.0, 0.18)
		tween.tween_property(panel, "scale", Vector2(1.0, 1.0), 0.18)\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	if dim_bg:
		dim_bg.modulate.a = 0.0
		var tween2 := create_tween()
		tween2.tween_property(dim_bg, "modulate:a", 1.0, 0.18)

func close() -> void:
	if not _is_open:
		return
	var tween := create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 0.15)
	tween.parallel().tween_property(panel, "scale", Vector2(0.85, 0.85), 0.15)
	tween.tween_callback(_finish_close)

func _finish_close() -> void:
	_is_open = false
	visible = false
	popup_closed.emit()

func is_open() -> bool:
	return _is_open

func _unhandled_input(event: InputEvent) -> void:
	if not _is_open:
		return
	# Close on click outside the panel
	if event is InputEventMouseButton and (event as InputEventMouseButton).pressed:
		close()
		get_viewport().set_input_as_handled()

func _populate_care_tags(care_icons: Dictionary) -> void:
	if not care_tag_container:
		return
	for child in care_tag_container.get_children():
		child.queue_free()

	for key in care_icons.values():
		var chip := _make_care_chip(key)
		care_tag_container.add_child(chip)

func _make_care_chip(icon_key: String) -> PanelContainer:
	var chip := PanelContainer.new()
	var label := Label.new()
	label.text = CARE_ICON_LABELS.get(icon_key, icon_key)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	chip.add_child(label)
	chip.custom_minimum_size = Vector2(70, 36)
	# Tint background by icon type
	var bg_color: Color = CARE_ICON_COLORS.get(icon_key, Color(0.88, 0.86, 0.82))
	var style := StyleBoxFlat.new()
	style.bg_color = bg_color
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_left = 6
	style.corner_radius_bottom_right = 6
	chip.add_theme_stylebox_override("panel", style)
	return chip

func _color_for_key(color_key: String) -> Color:
	const MAP := {
		"white":       Color(0.96, 0.94, 0.91),
		"cream":       Color(0.96, 0.94, 0.91),
		"light_gray":  Color(0.85, 0.84, 0.82),
		"light_blue":  Color(0.77, 0.87, 0.93),
		"light_pink":  Color(0.96, 0.82, 0.84),
		"light_yellow":Color(0.98, 0.95, 0.75),
		"black":       Color(0.17, 0.20, 0.25),
		"dark_blue":   Color(0.18, 0.27, 0.43),
		"dark_gray":   Color(0.35, 0.34, 0.33),
		"red":         Color(0.84, 0.25, 0.27),
		"navy":        Color(0.11, 0.17, 0.30),
	}
	return MAP.get(color_key, Color(0.9, 0.9, 0.9))
