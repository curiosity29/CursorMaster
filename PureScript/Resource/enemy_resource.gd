class_name EnemyResource
extends Resource


@export var id: String = ""
@export var name: String = ""
@export var scene: PackedScene

@export var health: int = 20
@export var speed: int = 60
@export var damage: int = 5
@export var attack_speed: float = 1.


func report():
	print("		reporting for enemy resource: ")
	for property in get_property_list():
		if property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			print("%s: %s" % [property.name, str(get(property.name))])
	print()
