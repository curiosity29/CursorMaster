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
	"spawn_delay": 2.5,
}
@export var spawn_policy_sprinter: Dictionary = {
	"id": "sprinter",
	"start_time": 20.,
	"spawn_delay": 2.2,
}
@export var spawn_policy_trojan_horse: Dictionary = {
	"id": "trojan_horse",
	"start_time": 55.,
	"spawn_delay": 5.,
}

@export var spawn_policy_ad_carry: Dictionary = {
	"id": "ad_carry",
	"start_time": 40.,
	"spawn_delay": 6.5,
}


func _ready() -> void:
	#timer.start()
	#timer.timeout.connect(spawn_enemy)
	setup_spawner_timer()
	setup_spawn_rate_scaling()

var spawn_timers: Array[Timer]
func setup_spawner_timer():
	for spawn_policy in [spawn_policy_slow, spawn_policy_sprinter, spawn_policy_trojan_horse]:
		var timer = Timer.new()
		timer.wait_time = spawn_policy["spawn_delay"] * difficulty_spawn_delay_mult[State.difficulty]
		timer.timeout.connect(spawn_enemy.bind(spawn_policy["id"]))
		add_child(timer)
		spawn_timers.append(timer)
		
		
		var start_spawn_timer = Timer.new()
		add_child(start_spawn_timer)
		start_spawn_timer.start(spawn_policy["start_time"])
		start_spawn_timer.one_shot = true
		start_spawn_timer.timeout.connect(func(): timer.start())
		
		#get_tree().create_timer(spawn_policy["start_time"]).timeout.connect(func(): timer.start())
		

func setup_spawn_rate_scaling():
	var scale_spawn_timer = Timer.new()
	add_child(scale_spawn_timer)
	scale_spawn_timer.wait_time = State.second_per_round
	scale_spawn_timer.start()
	scale_spawn_timer.timeout.connect(scale_spawn_timer_per_round)

func scale_spawn_timer_per_round():
	for timer: Timer in spawn_timers:
		timer.wait_time = timer.wait_time * 0.8
		timer.start()
	
	
func spawn_enemy(enemy_id: String = "slowpoke"):
	var enemy: Enemy = InstanceHelper.create_enemy(enemy_id)
	#get_tree().current_scene.
	add_child(enemy)
	var spawn_point = global_position + Vector2(randf_range(0, size.x), randf_range(0, size.y))# - enemy.size/2
	enemy.global_position = spawn_point
	#print("spawning enemy")
	#InstanceHelper.
