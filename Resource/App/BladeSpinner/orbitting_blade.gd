class_name OrbittingBlade
extends Control

@onready var area_2d: Area2D = $Area2D
@export var damage: int = 30
var bot_owner: Node
var current_angle = 0.
@export var orbit_radius = 160
@export var rotating_speed: float = PI/2

func _ready() -> void:
	if not bot_owner:
		bot_owner = get_parent()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_queued_for_deletion(): return
	if CombatHelper.damage_area_entered(damage, area):
		queue_free()
		#call_deferred("queue_free")
	
func _process(delta: float) -> void:
	global_position = bot_owner.global_position + orbit_radius * Vector2(cos(current_angle), sin(current_angle))
	current_angle += rotating_speed * delta
