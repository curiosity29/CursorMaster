extends Control

@onready var debug_container: Control = %DebugContainer

@export var do_debug: bool = false
func _ready() -> void:
	#Input.set_custom_mouse_cursor(preload("res://Resource/Texture/anti_virus_cursor.png"))
	State.reset_all()
	State.is_playing = true

	if not do_debug:
		debug_container.queue_free()

func _exit_tree() -> void:
	State.is_playing = false
	State.cursor_manager = Database.cursor_map["default"]
