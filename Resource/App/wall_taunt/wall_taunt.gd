extends App
#Wall that does NOT taunt
@onready var hp_label: RichTextLabel = $VBoxContainer/TextureRect/HPLabel
var hp_label_format: String = "HP: %d"
@export var health : int = 2^63-1

var aoe : int = 20
var dmg : int = 5
var tick : float = 0.1
var clock = Timer.new()
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func dmg_aoe() -> void:
	for enemy: Enemy in State.get_tree().get_nodes_in_group("Enemy"):
		if (area_2d.overlaps_area(enemy.hit_box)):
			enemy.take_damage(dmg, self)

var targetable_manager = TargetableManager

@onready var v_box_container: VBoxContainer = $VBoxContainer

var priority = 0
func _exit_tree() -> void:
	InstanceHelper.targets.erase(targetable_manager)
	
func update_health():
	hp_label.text = hp_label_format % targetable_manager.health
	
func get_target_pos():
	return global_position + size/2
	
func on_death():
	InstanceHelper.targets.erase(targetable_manager)
	call_deferred("queue_free")
	
func _ready() -> void:
	super()
	add_child(clock)
	targetable_manager = TargetableManager.new(health, get_target_pos , priority)
	targetable_manager.dead.connect(on_death, CONNECT_ONE_SHOT)
	InstanceHelper.targets.append(targetable_manager)
	targetable_manager.stats_changed.connect(update_health)
	(collision_shape_2d.shape as RectangleShape2D).size = Vector2(v_box_container.size.x + aoe, v_box_container.size.y + aoe)
	clock.wait_time = tick
	clock.timeout.connect(dmg_aoe)
	clock.start()
	update_health()
