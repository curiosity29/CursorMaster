extends App

@export var heat_cost_per_sec: float = 1.5
var is_mining: bool = false
var progress: float = 0.
@export var progress_speed: float = 0.2
@export var coin_per_mine: int = 1
@onready var progress_ui: ColorRect = $VBoxContainer/Progress
@onready var mine_toggle_button: CheckButton = $VBoxContainer/MineToggleButton


func _ready() -> void:
	super()
	progress_ui.material.set_shader_parameter("progress", progress)
	mine_toggle_button.set_pressed_no_signal(true) 
	_on_mine_toggle_button_toggled(true)

func on_open() -> void:
	pass

func _process(delta: float) -> void:
	super._process(delta)
	if is_mining:
		var heat_cost = heat_cost_per_sec * delta
		if State.heat_value_left >= heat_cost:
			State.heat_value += heat_cost
			progress += progress_speed * delta
			if progress >= 1.:
				State.bytecoin += 1
				progress -= 1.
			progress_ui.material.set_shader_parameter("progress", progress)


func _on_mine_toggle_button_toggled(toggled_on: bool) -> void:
	is_mining = toggled_on
	if toggled_on:
		mine_toggle_button.text = "Turned ON"
	else:
		mine_toggle_button.text = "Turned OFF"
