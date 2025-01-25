class_name Enemy
extends CharacterBody2D
#region component
@onready var nav_agent: NavigationAgent2D = $Node2D/NavigationAgent2D
@onready var target: TargetableManager:
	get:
		## if core not created, stand still
		return CombatHelper.select_target(global_position)
@onready var texture_rect: TextureRect = %TextureRect

var health: int = 20
var speed: int = 60
var damage: int = 5
var attack_speed: float = 1.
const attack_range: int = 100

@onready var enemy_resource: EnemyResource:
	set(value):
		enemy_resource = value
		for param_name in ["health", "speed", "damage", "attack_speed"]:
			set(param_name, enemy_resource.get(param_name))
#endregion



func _ready() -> void:
	if not enemy_resource:
		enemy_resource = load("res://Resource/Enemy/TestEnemy/test_enemy.tres")
	#enemy_resource.report()
	lazy_difficulty_scaling()
	
func lazy_difficulty_scaling():
	match State.difficulty:
		State.Difficulty.EASY:
			health *= 1
		State.Difficulty.NORMAL:
			health *= 2.
		State.Difficulty.HARD:
			health *= 4.
	health *= 1 + (State.elapsed_time/60.) * 0.3 # +30% base per min

func _process(delta: float) -> void:
	#return
	#region check if at destination
	if nav_agent.distance_to_target() < attack_range:
		target.take_damage(damage, self)
		call_deferred("queue_free")
		
		return
	#endregion
	
	#region navigate
	var target_global_pos = CombatHelper.select_target(global_position).position_getter.call()
	nav_agent.target_position = target_global_pos
	var direction = global_position.direction_to(nav_agent.get_next_path_position())
	#global_position += direction * enemy_resource.speed * delta
	var acceleration = speed * 1.5
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	
	move_and_slide()
	#print((next_target_pos - global_position).normalized() * enemy_resource.speed)
	#global_position = next_pos
	#print(global_position, next_pos)
	#endregion
	
#region logic
var is_dead: bool:
	get:
		return health <= 0
		
func take_damage(value: int, _source: Node = null):
	health -= value
	AnimationHelper.spawn_damage_indicator(value, global_position + texture_rect.size/2)
	#print("taking %d damage" % value)
	if is_dead:
		on_dead()
		
func on_dead():
	call_deferred("queue_free")
#endregion
