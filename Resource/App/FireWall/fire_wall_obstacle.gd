class_name FireWallObstacle
extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

const tween_time: float = 1.2

func _ready() -> void:
	collision_shape_2d.scale = Vector2.ZERO
	area_grow_tween()
	animation_player.play("moveAndGrow")

func area_grow_tween():
	var tween = create_tween()
	tween.tween_property(collision_shape_2d, "scale", Vector2.ONE, tween_time)
