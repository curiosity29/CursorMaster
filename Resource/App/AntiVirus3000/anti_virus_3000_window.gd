extends AppWindow

@export var damage: int = 3

#@onready var on_off_hitting_timer: Timer = %OnOffHittingTimer
@onready var hitting_box: Area2D = %HittingBox
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _ready() -> void:
	super()
	resize_hitting_box()
	#header.close_button.
	
func resize_hitting_box():
	var rectangle = RectangleShape2D.new()
	rectangle.size = body.size
	collision_shape_2d.shape = rectangle
	collision_shape_2d.position = rectangle.size/2

func _on_hitting_box_area_entered(area: Area2D) -> void:
	CombatHelper.damage_area_entered(damage, area)

func _on_on_off_hitting_timer_timeout() -> void:
	hitting_box.monitoring = !hitting_box.monitoring

func _on_body_resized() -> void:
	resize_hitting_box()
