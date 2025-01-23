extends AppWindow

@onready var clean_area: Control = $MarginContainer/VBoxContainer/Body/CleanArea
const speed: float = 50.
var current_direction: Vector2
func _process(delta: float) -> void:
	current_direction = pick_random_direction()
	clean_area.position = (clean_area.position + current_direction * speed * delta).clamp(Vector2.ZERO, body.size)

func pick_random_direction() -> Vector2:
	
	return Vector2.DOWN
