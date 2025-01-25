#Navigator
extends Control

@export var MENU_SCENE: PackedScene
@export var MAIN_RUN_SCENE: PackedScene
@export var END_RUN_SCENE: PackedScene

@onready var main_scene_container: Control = %MainSceneContainer

var main_scene: Node:
	get:
		return main_scene_container.get_child(0)

func change_scene(packed_scene: PackedScene):
	#get_tree().paused = true
	#print("paused")
	main_scene.queue_free()
	var new_scene = packed_scene.instantiate()
	main_scene_container.add_child(new_scene)
	#get_tree().paused = false
	#print("resumed")
	
func _ready() -> void:
	
	connect_router()
	change_scene(MENU_SCENE)
	
func connect_router():
	Event.run_start_request.connect(change_scene.bind(MAIN_RUN_SCENE))
	Event.exit_to_menu_request.connect(change_scene.bind(MENU_SCENE))
	Event.run_end_request.connect(change_scene.bind(END_RUN_SCENE))
	
