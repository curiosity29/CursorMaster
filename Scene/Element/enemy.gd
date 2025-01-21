class_name Enemy
extends Control
#region component
@onready var nav_agent: NavigationAgent2D = $Node2D/NavigationAgent2D
@onready var target: Core:
	get:
		## if core not created, stand still
		return InstanceHelper.core# if InstanceHelper.core else self

@export var health: int = 20
@export var speed: int = 60
@export var damage: int = 5
@export var attack_speed: float = 1.
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


func _process(delta: float) -> void:
	#return
	#region check if at destination
	if nav_agent.distance_to_target() < attack_range:
		target.take_damage(damage, self)
		call_deferred("queue_free")
		
		return
	#endregion
	
	#region navigate
	nav_agent.target_position = target.global_position
	var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	global_position += direction * enemy_resource.speed * delta
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
	AnimationHelper.spawn_damage_indicator(value, global_position + size/2)
	#print("taking %d damage" % value)
	if is_dead:
		on_dead()
		
func on_dead():
	call_deferred("queue_free")
#endregion
