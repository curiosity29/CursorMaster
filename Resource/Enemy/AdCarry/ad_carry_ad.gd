extends AppWindow



func _on_button_pressed() -> void:
	var my_packed_scene: PackedScene = load(scene_file_path)
	var new_scene: AppWindow = my_packed_scene.instantiate()
	var map = InstanceHelper.map
	map.add_child(new_scene)
	new_scene.position = Vector2(randi_range(0, map.size.x-new_scene.size.x), randi_range(0, map.size.y - new_scene.size.y))
