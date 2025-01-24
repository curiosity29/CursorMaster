#State
extends Node2D

signal task_stats_changed
var bytecoin: int = 20
var ram_value: float = 0.:
	set(value):
		ram_value = value
		task_stats_changed.emit()
var heat_value: float = 0.:
	set(value):
		heat_value = value
		task_stats_changed.emit()
var max_ram_value: float = 128.:
	set(value):
		max_ram_value = value
		task_stats_changed.emit()
var max_heat_value: float = 70.:
	set(value):
		max_heat_value = value
		task_stats_changed.emit()

var ram_value_left: float:
	get: return max_ram_value - ram_value
var heat_value_left: float:
	get: return max_heat_value - heat_value

var owned_app_list: Array[AppResource]

#var APP_SCENE = preload("res://Scene/Element/App.tscn")

func _ready() -> void:
	if Database.is_node_ready(): set_default_cursor()
	else: Database.ready.connect(set_default_cursor, CONNECT_ONE_SHOT)
	
	Event.app_buy_request.connect(on_app_buy)
	
func on_app_buy(app_resource: AppResource):
	var new_app: App = app_resource.app_scene.instantiate()
	InstanceHelper.map.add_child(new_app)
	new_app.global_position = InstanceHelper.map.global_position + InstanceHelper.map.size/2
		
func set_default_cursor():
	cursor_manager = Database.cursor_map["default"]
var cursor_manager: CursorManagerResource:
	set(value):
		if cursor_manager: cursor_manager.on_unset()
		cursor_manager = value
		cursor_manager.on_set()


func on_click(click_pos: Vector2 = get_global_mouse_position()):
	cursor_manager.on_click(click_pos, self)
func on_right_click(click_pos: Vector2 = get_global_mouse_position()):
	cursor_manager.on_right_click(click_pos, self)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		#print("click event: ", event)
		if event.is_action_pressed("click"): on_click(event.global_position)
		elif event.is_action_pressed("right_click"): on_right_click(event.global_position)
