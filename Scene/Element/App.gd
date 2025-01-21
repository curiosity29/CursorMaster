class_name App
extends Control

@onready var double_click_timer: Timer = $DoubleClickTimer
@export var app_name: String = "unimplemented app"
@export var app_window_scene: PackedScene
@onready var app_name_label: RichTextLabel = $VBoxContainer/AppNameLabel

func _ready() -> void:
	app_name_label.text = app_name
	#double_click_timer.timeout.connect(func(): first_clicked = false)
	pass


#region on click open
var first_clicked: bool = false

func _on_button_pressed() -> void:
	if first_clicked:
		on_open()
		double_click_timer.stop()
		first_clicked = false
	else:
		first_clicked = true
		double_click_timer.start()
	
#endregion

#region self helper
func open_window(global_pos: Vector2 = global_position, max_size: Vector2 = Vector2(300, 300)) -> void:
	var app_window: AppWindow = app_window_scene.instantiate()
	app_window.max_size = max_size
	app_window.app_name = app_name
	get_parent().add_child(app_window)
	app_window.global_position = global_pos

#endregion
#region overwrite
func on_open() -> void:
	#print("opening window")
	open_window()


#endregion


func _on_double_click_timer_timeout() -> void:
	first_clicked = false
	#print("first click timeout")
