class_name ShotgunCursorApp
extends App
@onready var ammon_label: Label = $AmmonLabel

func on_open() -> void:
	State.cursor_manager = Database.cursor_map["shotgun"]
	State.cursor_manager.root_app = self

func _ready() -> void:
	super()
	ammo = max_ammo
	
@export var max_ammo: int = 8
var ammo: int = max_ammo:
	set(value):
		ammo = value
		ammon_label.text = "ammo: %d/%d" % [ammo, max_ammo]


func _on_ammo_timer_timeout() -> void:
	ammo = min(max_ammo, ammo + 1)
