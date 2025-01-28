class_name Core
extends App
@onready var hp_label: RichTextLabel = $HPLabel

const hp_label_format = "HP: %d"
@export var health: int = 50
	#set(value):
		#health = value
		#if is_node_ready(): hp_label.text = hp_label_format % health
		#else: ready.connect(func(): hp_label.text = hp_label_format % health, CONNECT_ONE_SHOT)

var targetable_manager: TargetableManager

func _ready() -> void:
	super()
	InstanceHelper.core = self
	targetable_manager = TargetableManager.new(health, get_target_pos, 0, "core")
	InstanceHelper.targets.append(targetable_manager)
	targetable_manager.stats_changed.connect(update_health)
	targetable_manager.dead.connect(on_dead)
	update_health()
	
func _exit_tree() -> void:
	InstanceHelper.targets.erase(targetable_manager)
	
func on_dead():
	State.run_end_state = State.RunEndState.LOSE
	Event.run_end_request.emit()

func update_health():
	hp_label.text = hp_label_format % targetable_manager.health

func get_target_pos():
	return global_position + size/2

func _process(delta: float) -> void:
	## stop this from dragging
	pass

#func take_damage(value: int, _source: Enemy = null):
	#targetable_manager.take_damage(value)

func on_open() -> void:
	pass
