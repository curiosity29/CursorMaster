extends App

@export var wall_scene: PackedScene
var wall_node: FireWallObstacle

func on_open() -> void:
	#print("...")
	if wall_node: wall_node.queue_free()
	wall_node = wall_scene.instantiate()
	#print(wall_node.size)
	InstanceHelper.obstacle_container.add_child(wall_node)
	#print("added obs")
	var start_pos = global_position + size/2 - wall_node.size/2
	var final_pos = start_pos + Vector2.RIGHT * 150
	wall_node.global_position = start_pos
	#print("pos ", wall_node.position)
	var tween = create_tween()
	tween.tween_property(wall_node, "global_position", final_pos, 1.2)
	tween.finished.connect(func(): InstanceHelper.nav_region.update())
	
	#print(wall_node.size)
	#print(InstanceHelper.obstacle_container.get_children())
	#for child in InstanceHelper.obstacle_container.get_children():
		##print(child.)
		#pass
	#wall_node.
