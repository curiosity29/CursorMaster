class_name MatrixCellTrap
extends Control

@onready var area_2d: Area2D = $Area2D
@export var damage: int = 60
var activated: bool = false:
	set(value):
		activated = value
		#area_2d.monitoring = !area_2d.monitoring
		if activated: 
			modulate.a = 1.
			area_2d.monitoring = true
		else: 
			#area_2d.monitoring = false
			call_deferred("wtf")
			#print("setting to false")
			#print(area_2d.monitoring)
			modulate.a = 0.
			
func wtf():
	## BUG NOTE: need to set monitoring in deffered 
	## no idea why the f setting monitoring not working in activated setter

	area_2d.monitoring = false

func _ready() -> void:
	activated = false
	##area_2d.are
	#pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not activated: return
	if CombatHelper.damage_area_entered(damage, area):
	#call_deferred("queue_free")
		activated = false


#func _on_timer_timeout() -> void:
	#area_2d.monitoring = !area_2d.monitoring
	#print(area_2d.monitoring)
