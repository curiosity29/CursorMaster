class_name Core
extends App
@onready var hp_label: RichTextLabel = $HPLabel

const hp_label_format = "HP: %d"
@export var health: int = 50:
	set(value):
		health = value
		if is_node_ready(): hp_label.text = hp_label_format % health
		else: ready.connect(func(): hp_label.text = hp_label_format % health, CONNECT_ONE_SHOT)

func _ready() -> void:
	super()
	InstanceHelper.core = self

func take_damage(value: int, _source: Enemy = null):
	health -= value

func on_open() -> void:
	pass
