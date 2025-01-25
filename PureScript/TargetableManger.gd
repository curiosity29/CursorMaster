class_name TargetableManager
extends Object
signal dead
signal took_damage(int)
signal stats_changed

var health: int:
	set(value):
		var is_dead_before = is_dead
		health = value
		stats_changed.emit()
		if !is_dead_before and is_dead: 
			dead.emit()
var priority: int = 0
var is_dead: bool:
	get:
		return health <= 0


var position_getter: Callable ## no argument func to get the position of the target
var attackable_radius: int = 64
var name: String = ""

func _init(init_health: int, init_position_getter: Callable, init_priority: int = 0, init_name: String = "") -> void:
	health = init_health
	priority = init_priority
	position_getter = init_position_getter
	name = init_name
	
func take_damage(value: int, _source: Enemy = null):
	took_damage.emit(value)
	health -= value
