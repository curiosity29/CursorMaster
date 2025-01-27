extends Control

@onready var debug_container: Control = %DebugContainer
@onready var init_app_container: Control = $HBoxContainer/Map/InitAppContainer

@export var do_debug: bool = false
func _ready() -> void:
	#Input.set_custom_mouse_cursor(preload("res://Resource/Texture/anti_virus_cursor.png"))
	State.reset_all()
	State.is_playing = true

	if not do_debug:
		debug_container.queue_free()
	set_initial_app_possesion()

func set_initial_app_possesion():
	for app: App in init_app_container.get_children():
		if app.is_queued_for_deletion(): continue
		#print(app.app_resource_id)
		var app_resource = Database.app_map[app.app_resource_id]
		State.owned_apps[app_resource] = app
	
func _exit_tree() -> void:
	State.is_playing = false
	State.cursor_manager = Database.cursor_map["default_cursor"]
