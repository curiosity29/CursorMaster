class_name CursorManagerResource
extends Resource

@export var id: String
@export var name: String
@export var app_id: String

@export var cursor_hotspot: Vector2 = Vector2.ZERO
@export var cursor_texture: Texture

#region effect for overwrite
func on_set():
	#Input.set_custom_mouse_cursor(cursor_texture)
	Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, cursor_hotspot)
	#print("setting to ", cursor_texture.resource_path, cursor_hotspot)
func on_unset():
	pass

func on_click(_mouse_pos: Vector2, _source: Node2D = null) -> void:
	pass
	
func on_right_click(_mouse_pos: Vector2, _source: Node2D = null) -> void:
	pass
	
#endregion
