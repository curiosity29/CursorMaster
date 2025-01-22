extends App

@export var popup_effect_scene: PackedScene

func on_open() -> void:
	var professor_popup = popup_effect_scene.instantiate()
	add_child(professor_popup)
	professor_popup.global_position = get_viewport_rect().size - Vector2(700, 0)
