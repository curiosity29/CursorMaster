class_name TargetableManager
extends Object
signal dead

var health: int:
	set(value):
		health = value
		if is_dead: dead.emit()
var priority: int = 0
var is_dead: bool:
	get:
		return health <= 0
var position_getter: Callable ## no argument func to get the position of the target
var attackable_radius: int = 64


func _init(init_health: int, init_position_getter: Callable, init_priority: int = 0) -> void:
	health = init_health
	priority = init_priority
	position_getter = init_position_getter
	
func take_damage(value: int, _source: Enemy = null):
	health -= value
	
