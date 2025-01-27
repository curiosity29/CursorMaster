# InstanceHelper
extends Node
#Priority table for gamestate
var targets: Array[TargetableManager]:
	get:
		# catch all remove null
		targets = targets.filter(func(target): return target)
		return targets
var map: Map
var core: Core
var obstacle_container: Control
var task_manager: TaskManager
var nav_regions: Array[MainNavRegion]
const APP_WINDOW = preload("res://Scene/Element/app_window.tscn")

func update_nav_regions():
	for nav_region in nav_regions:
		nav_region.update()

func create_enemy(id: String) -> Enemy:
	var enemy_resource = Database.enemy_map[id]
	var enemy: Enemy = enemy_resource.scene.instantiate()
	enemy.enemy_resource = enemy_resource
	return enemy

func create_app_window(app_name: String = "", max_size: Vector2 = Vector2(300, 300)) -> AppWindow:
	var app_window: AppWindow = APP_WINDOW.instantiate()
	app_window.max_size = max_size
	app_window.app_name = app_name
	return app_window

func simulate_click_action(click_pos: Vector2):
	var click_action = InputEventMouseButton.new()
	click_action.global_position = click_pos
	click_action.position = click_pos
	click_action.pressed = true
	click_action.button_index = 1
	Input.parse_input_event(click_action)
	
	#click_action = InputEventMouseButton.new()
	#click_action.global_position = click_pos
	#click_action.pressed = false
	#click_action.button_index = 1
	#Input.parse_input_event(click_action)
