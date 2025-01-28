class_name App
extends Control

@onready var double_click_timer: Timer = $DoubleClickTimer
@export var app_name: String = "unimplemented app"
@export var app_window_scene: PackedScene
@export var open_heat_cost: float = 0.
@onready var app_name_label: RichTextLabel = $VBoxContainer/AppNameLabel
var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
@export var app_resource_id: String
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


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"): 
		is_dragging = true
		drag_offset = global_position - get_global_mouse_position()
func _input(event: InputEvent) -> void:
	if event.is_action_released("click"): 
		is_dragging = false
func _process(delta: float) -> void:
	## drag and confine it in map
	var max_pos: Vector2 = InstanceHelper.map.global_position + InstanceHelper.map.size - size
	if is_dragging:
		global_position = (get_global_mouse_position() + drag_offset).clamp(
			InstanceHelper.map.global_position, max_pos
		)
		
#region self helper
func open_window(global_pos: Vector2 = global_position) -> void:
	if not app_window_scene: return

	var app_window: AppWindow = app_window_scene.instantiate()
	if app_window.ram_cost > State.ram_value_left:
		app_window.queue_free()
		return

	app_window.app_name = app_name
	InstanceHelper.map.add_child(app_window)
	#get_tree().current_scene.add_child(app_window)
	#print(app_window.size)
	app_window.global_position = InstanceHelper.map.global_position + InstanceHelper.map.size/2 - app_window.size/2
	#app_window.global_position = get_viewport_rect().size/2 - app_window.size/2
#endregion
#region overwrite
func on_open() -> void:
	State.heat_value += open_heat_cost
	#print("opening window")
	open_window()


#endregion


func _on_double_click_timer_timeout() -> void:
	first_clicked = false
	#print("first click timeout")
