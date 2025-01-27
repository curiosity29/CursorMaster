#State
extends Node2D

signal task_stats_changed
@export var starting_bytecoin: int = 20
var bytecoin: int:
	set(value):
		bytecoin = value
		task_stats_changed.emit()
var ram_value: float = 0.:
	set(value):
		ram_value = value
		task_stats_changed.emit()
var heat_value: float = 0.:
	set(value):
		heat_value = value
		task_stats_changed.emit()
var max_ram_value: float = 64.:
	set(value):
		max_ram_value = value
		task_stats_changed.emit()
var max_heat_value: float = 50.:
	set(value):
		max_heat_value = value
		task_stats_changed.emit()

var ram_value_left: float:
	get: return max_ram_value - ram_value
var heat_value_left: float:
	get: return max_heat_value - heat_value

var heat_reduction_speed: float = 1.

var owned_app_list: Array[AppResource]

enum Difficulty {EASY, NORMAL, HARD}
var difficulty: Difficulty = Difficulty.EASY

var elapsed_time: float = 0.
const WIN_TIME: float = 150
enum RunEndState {WIN, LOSE}
var run_end_state: RunEndState = RunEndState.LOSE
var is_playing: bool = false

var income_timer: Timer = Timer.new()
const second_per_round: int = 30
@export var passive_income_per_round: int = 10
#var APP_SCENE = preload("res://Scene/Element/App.tscn")

func _ready() -> void:
	if Database.is_node_ready(): set_default_cursor()
	else: Database.ready.connect(set_default_cursor, CONNECT_ONE_SHOT)
	
	Event.app_buy_request.connect(on_app_buy)
	income_timer.wait_time = second_per_round
	income_timer.timeout.connect(get_passive_income_per_min)
	add_child(income_timer)
	
func on_app_buy(app_resource: AppResource):
	var new_app: App = app_resource.app_scene.instantiate()
	InstanceHelper.map.add_child(new_app)
	#new_app.global_position = InstanceHelper.map.global_position + InstanceHelper.map.size/2
	new_app.global_position = InstanceHelper.core.global_position

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
	
	elif event.is_action_pressed("tab"):
		cursor_manager = Database.cursor_map["ui_cursor"]

func _process(delta: float) -> void:
	heat_value = move_toward(heat_value, 0., heat_reduction_speed * delta)
	if is_playing:
		elapsed_time += delta
		if elapsed_time > WIN_TIME:
			run_end_state = RunEndState.WIN
			Event.run_end_request.emit()
			# prevent multiple request
			#print("run end request")
			elapsed_time = 0.

func get_passive_income_per_min():
	bytecoin += passive_income_per_round

func reset_all():
	# place holder func to reset all var on starting new run 
	# NOTE: currently thing will not work on second run
	bytecoin = starting_bytecoin
	elapsed_time = 0.
	owned_app_list.clear()
	income_timer.start()
