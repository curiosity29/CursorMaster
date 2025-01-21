class_name DamageIndicator
extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed: int = 30
@export var friction: int = 15
var shift_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	shift_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	animation_player.play("showDamage")
func set_damage_value(value: int):
	rich_text_label.text = str(value)

func _process(delta: float) -> void:
	global_position += speed * shift_direction * delta
	speed = max(speed-friction * delta, 0)
