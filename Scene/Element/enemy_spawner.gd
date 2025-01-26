class_name EnemySpawner
extends Control
@onready var timer: Timer = $Timer

@export var difficulty_spawn_delay_mult = {
	State.Difficulty.EASY: 1.2,
	State.Difficulty.NORMAL: 1.,
	State.Difficulty.HARD: 0.8,
}

@export var spawn_policy_slow: Dictionary = {
	"id": "slowpoke",
	"start_time": 0.,
	"spawn_delay": 0.8,
}
@export var spawn_policy_sprinter: Dictionary = {
	"id": "sprinter",
	"start_time": 20.,
	"spawn_delay": 1.2,
}
@export var spawn_policy_trojan_horse: Dictionary = {
	"id": "trojan_horse",
	"start_time": 50.,
	"spawn_delay": 3.,
}

func _ready() -> void:
	#timer.start()
	#timer.timeout.connect(spawn_enemy)
	setup_spawner_timer()
	
func setup_spawner_timer():
	for spawn_policy in [spawn_policy_slow, spawn_policy_sprinter, spawn_policy_trojan_horse]:
		var timer = Timer.new()
		timer.wait_time = spawn_policy["spawn_delay"] * difficulty_spawn_delay_mult[State.difficulty]
		get_tree().create_timer(spawn_policy["start_time"]).timeout.connect(func(): timer.start())
		timer.timeout.connect(spawn_enemy.bind(spawn_policy["id"]))
		add_child(timer)

func spawn_enemy(enemy_id: String = "slowpoke"):
	var enemy: Enemy = InstanceHelper.create_enemy(enemy_id)
	#get_tree().current_scene.
	add_child(enemy)
	var spawn_point = global_position + Vector2(randf_range(0, size.x), randf_range(0, size.y))# - enemy.size/2
	enemy.global_position = spawn_point
	#print("spawning enemy")
	#InstanceHelper.
