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
@export var is_transparent_body: bool = false
@export var app_window_name: String = ""

var app_name: String:
	set(value):
		app_name = value
		if is_node_ready(): app_name_label.text = app_window_name
		else: ready.connect(func(): app_name_label.text = app_window_name, CONNECT_ONE_SHOT)

func _ready() -> void:
	#size = max_size
	setup_signal()

	

func setup_signal():
	header.close_button_pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed() -> void:
	call_deferred("queue_free")



		
