class_name MainNavRegion
extends NavigationRegion2D
@onready var obstacle_container: Control = %ObstacleContainer

func _ready() -> void:
	InstanceHelper.nav_region = self
	#obstacle_container.child_order_changed.connect(
		#func():
			#call_deferred("update")
	#)
	

#func debug_baking():
	#if obstacle_container.get_child_count() > 2:
		#return
	#print("baking ", obstacle_container.get_child_count())
	

func update():
	bake_navigation_polygon()
