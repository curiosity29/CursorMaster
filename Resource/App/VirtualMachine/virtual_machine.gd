extends App


@export var health: int = 50
@export var priority: int = 10
var targetable_manager: TargetableManager
func _ready() -> void:
	super()
	targetable_manager = TargetableManager.new(health, get_global_pos , priority)
	InstanceHelper.targets.append(targetable_manager)
	targetable_manager.dead.connect(on_death, CONNECT_ONE_SHOT)
	#InstanceHelper.core = self
func get_global_pos():
	return global_position
	
func on_death():
	InstanceHelper.targets.erase(targetable_manager)
	
func take_damage(value: int, _source: Enemy):
	targetable_manager.take_damage(value, _source)
