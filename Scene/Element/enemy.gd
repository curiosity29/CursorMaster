class_name Enemy
extends CharacterBody2D
#region component
@onready var nav_agent: NavigationAgent2D = $Node2D/NavigationAgent2D
@onready var target: TargetableManager:
	get:
		## if core not created, stand still
		return CombatHelper.select_target(global_position)
@onready var texture_rect: TextureRect = %TextureRect
var size: Vector2:
	get: return texture_rect.size
@onready var hit_box: Area2D = $HitBox
var health: int = 20
var speed: int = 60
var damage: int = 5
var attack_speed: float = 1.
const attack_range: int = 100
@export var starting_look_direction: Vector2 = Vector2.LEFT
@onready var enemy_resource: EnemyResource:
	set(value):
		if not value: return
		enemy_resource = value
		for param_name in ["health", "speed", "damage", "attack_speed"]:
			set(param_name, enemy_resource.get(param_name))
#endregion
@onready var debug_direction_color_rect: ColorRect = $DebugDirectionColorRect

@export var enemy_resource_id: String

func _ready() -> void:
	if not enemy_resource and enemy_resource_id:
		# this should only matter during debug (instatiate enemy scene in the editor)
		#call_deferred("debug_set_resource")
		debug_set_resource()
	#enemy_resource.report()
	lazy_difficulty_scaling()

func debug_set_resource():
	enemy_resource = Database.enemy_map[enemy_resource_id]
	assert(enemy_resource.scene.resource_path == scene_file_path)

func lazy_difficulty_scaling():
	match State.difficulty:
		State.Difficulty.EASY:
			health *= 0.7
		State.Difficulty.NORMAL:
			health *= 1.
		State.Difficulty.HARD:
			health *= 1.3
			
	health *= 1 + (State.elapsed_time/State.second_per_round) * 0.5 # +50% base per round

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
	var current_direction = velocity.normalized()
	var acceleration = speed * 1.5
	var brake_acceleration = 600
	var brake_vector_length = (1 - direction.dot(current_direction))/2
	velocity = velocity.move_toward(direction * speed, brake_vector_length * brake_acceleration * delta)
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	look_at(global_position - direction)
	move_and_slide()
	debug_direction_color_rect.rotation = velocity.angle() - rotation
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
	queue_free()
	#call_deferred("queue_free")
#endregion
