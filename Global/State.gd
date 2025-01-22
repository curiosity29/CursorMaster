#State
extends Node2D

func _ready() -> void:
	if Database.is_node_ready(): set_default_cursor()
	else: Database.ready.connect(set_default_cursor, CONNECT_ONE_SHOT)
		
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
