extends Enemy

@export var summon_id = "sprinter"
@export var summon_count: int = 10
@export var summon_radius: float = 196
func on_dead():
	super.on_dead()
	
	var sprinter: Enemy
	for index in summon_count:
		var angle = index * TAU / summon_count
		sprinter = InstanceHelper.create_enemy(summon_id)
		InstanceHelper.map.add_child(sprinter)
		sprinter.global_position = global_position + Vector2(cos(angle), sin(angle)) * summon_radius - sprinter.size/2
	
