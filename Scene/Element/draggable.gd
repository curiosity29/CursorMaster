class_name Draggable
extends Control

var is_picked_up: bool = false
#@export var damage: int = 10
func _ready() -> void:
	pass
func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		is_picked_up = true

func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("click") and get_global_rect().has_point(get_global_mouse_position()):
		#is_picked_up = true
		
	if event.is_action_released("click"):
		is_picked_up = false

func _process(delta: float) -> void:
	if not is_picked_up:
		return
	# follow mouse
	global_position = get_global_mouse_position() - size/2 # offset with size if anchor top left
	

#
#func _on_hitting_box_area_entered(area: Area2D) -> void:
	#if is_picked_up:
		#CombatHelper.damage_area_entered(damage, area)
	#var area_owner = area.owner
	#if area_owner is Enemy:
		#area_owner.take_damage(damage, self)
	#print(area.owner)
