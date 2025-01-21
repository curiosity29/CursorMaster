extends CursorManagerResource

@export var hitting_box_scene: PackedScene
var hitting_box: Node
func on_set() -> void:
	super.on_set()
	hitting_box = hitting_box_scene.instantiate()
	State.add_child(hitting_box)
	
func on_unset() -> void:
	super.on_unset()
	hitting_box.queue_free()
