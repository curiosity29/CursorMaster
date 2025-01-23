class_name Core
extends App
@onready var hp_label: RichTextLabel = $HPLabel

const hp_label_format = "HP: %d"
@export var health: int = 50:
	set(value):
		health = value
		if is_node_ready(): hp_label.text = hp_label_format % health
		else: ready.connect(func(): hp_label.text = hp_label_format % health, CONNECT_ONE_SHOT)

var targetable_manager: TargetableManager

func _ready() -> void:
	super()
	InstanceHelper.core = self
	targetable_manager = TargetableManager.new(health, get_global_pos, 0)
	InstanceHelper.targets.append(targetable_manager)

func get_global_pos():
	return global_position

func _process(delta: float) -> void:
	## stop this from dragging
	pass

func take_damage(value: int, _source: Enemy = null):
	targetable_manager.take_damage(value)

func on_open() -> void:
	pass
