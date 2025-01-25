extends App

@onready var hp_label: RichTextLabel = $VBoxContainer/TextureRect/HPLabel
var hp_label_format: String = "HP: %d"
@export var health: int = 50#:
	#set(value):
		#health = value
		#if is_node_ready(): hp_label.text = hp_label_format % health
		#else: ready.connect(func(): hp_label.text = hp_label_format % health, CONNECT_ONE_SHOT)
const heat_increase_speed: float = 30.
const min_heat_reserve = 10.
	
@export var priority: int = 10
var targetable_manager: TargetableManager
func _ready() -> void:
	super()
	targetable_manager = TargetableManager.new(health, get_target_pos , priority)
	targetable_manager.dead.connect(on_death, CONNECT_ONE_SHOT)
	InstanceHelper.targets.append(targetable_manager)
	targetable_manager.stats_changed.connect(update_health)
	
func _exit_tree() -> void:
	InstanceHelper.targets.erase(targetable_manager)
	
func update_health():
	hp_label.text = hp_label_format % targetable_manager.health
func get_target_pos():
	return global_position + size/2
	
func on_death():
	InstanceHelper.targets.erase(targetable_manager)
	call_deferred("queue_free")
	
#func take_damage(value: int, _source: Enemy = null):
	#print("take %d damage" % value)
	#targetable_manager.take_damage(value, _source)

func _process(delta: float) -> void:
	if State.heat_value_left < min_heat_reserve: is_dragging = false
	super._process(delta)
	if is_dragging: State.heat_value += heat_increase_speed * delta
	
