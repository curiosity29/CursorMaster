extends CursorManagerResource

const heat_cost: float = 0.
@export var effect_animation_scene: PackedScene
var root_app: ShotgunCursorApp
func on_set() -> void:
	super.on_set()
	
func on_click(mouse_pos: Vector2, source: Node2D = null) -> void:
	if not root_app: 
		#print("ERROR: missing ref to app")
		return

	## only cost heat if source is player clicking
	if source is State:
		if State.heat_value_left < heat_cost:
			return
		State.heat_value += heat_cost
	if root_app.ammo <= 0:
		return
	root_app.ammo -= 1
	var effect_animation = effect_animation_scene.instantiate()
	InstanceHelper.map.add_child(effect_animation)
	effect_animation.global_position = mouse_pos
	#effect_animation.global_position = State 
	#for enemy: Enemy in State.get_tree().get_nodes_in_group("Enemy"):
		#if (enemy.global_position - mouse_pos).length() < damage_radius:
			#enemy.take_damage(damage, State)
	
