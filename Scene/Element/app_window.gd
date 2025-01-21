class_name AppWindow
extends Control

@onready var header: AppHeader = %Header
@onready var grabber: Control:
	get:
		return header.grabber
@onready var app_name_label: RichTextLabel:
	get:
		return header.app_name_label
@onready var body: Control = %Body

@export var max_size: Vector2 = Vector2(300, 300)
var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var app_name: String:
	set(value):
		app_name = value
		if is_node_ready(): app_name_label.text = app_name
		else: ready.connect(func(): app_name_label.text = app_name, CONNECT_ONE_SHOT)

func _ready() -> void:
	#size = max_size
	setup_signal()

	

func setup_signal():
	header.close_button_pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed() -> void:
	call_deferred("queue_free")


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
		global_position = get_global_mouse_position() + drag_offset
