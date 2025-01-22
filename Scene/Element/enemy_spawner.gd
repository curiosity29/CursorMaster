class_name EnemySpawner
extends Control
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()
	timer.timeout.connect(spawn_enemy)
	
func spawn_enemy():
	var spawn_point = global_position + Vector2(randf_range(0, size.x), randf_range(0, size.y))
	var enemy = InstanceHelper.create_enemy("test_enemy")
	#get_tree().current_scene.
	add_child(enemy)
	enemy.global_position = spawn_point
	#print("spawning enemy")
	#InstanceHelper.
