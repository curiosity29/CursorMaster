extends CursorManagerResource

@export var hitting_box_scene: PackedScene
var hitting_box: DefaultCursorHittingBox
func on_set() -> void:
	super.on_set()
	hitting_box = hitting_box_scene.instantiate()
	
	State.add_child(hitting_box)
	hitting_box.overheat_malfunction.connect(AnimationHelper.spawn_overheat_indicator)

	
func on_unset() -> void:
	super.on_unset()
	hitting_box.queue_free()
