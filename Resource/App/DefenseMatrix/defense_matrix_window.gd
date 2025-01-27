extends AppWindow

@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/Body/GridContainer
@export var max_cell_count: int = 16
@export var cell_scene: PackedScene

func _on_recharge_timer_timeout() -> void:
	#var new_cell = cell_scene.instantiate()
	for cell: MatrixCellTrap in grid_container.get_children():
		if not cell.activated:
			cell.activated = true
			return
	
func _ready() -> void:
	super()
	
	
	#for child: MatrixCellTrap in grid_container:
		#child.queue_free()
