class_name AppHeader
extends Control

signal close_button_pressed
signal minimize_button_pressed
signal maximize_button_pressed

@onready var app_name_label: RichTextLabel = $HBoxContainer/Grabber/HBoxContainer/AppNameLabel
@onready var grabber: Control = %Grabber
@export var parent_app_node: Node

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _on_close_button_pressed() -> void:
	close_button_pressed.emit()

func _on_maximize_button_pressed() -> void:
	maximize_button_pressed.emit()

func _on_minimize_button_pressed() -> void:
	minimize_button_pressed.emit()

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if grabber.get_global_rect().has_point(get_global_mouse_position()):
			is_dragging = true
			drag_offset = global_position - get_global_mouse_position()
			
func _input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		is_dragging = false
	
func _process(_delta: float) -> void:
	if is_dragging:
		## NOTE: parent app window should have the same position as app header, otherwise need + parent offset
		var max_pos: Vector2 = get_viewport_rect().size - size
		parent_app_node.global_position = (get_global_mouse_position() + drag_offset).\
											clamp(Vector2.ZERO, max_pos)
