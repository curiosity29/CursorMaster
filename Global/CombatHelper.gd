#CombatHelper
extends Node


func damage_area_entered(damage: int, area: Area2D):
	#NOTE: this rely on each enemy having at most 1 area2d, which is a hit box
	#need to add group tag to area if it has non-hitbox area
	var area_owner = area.owner
	if area_owner is Enemy:
		area_owner.take_damage(damage, self)

func select_target() -> TargetableManager:
	# sort the whole array to get the minimum because lazy and can't find custom_min
	InstanceHelper.targets.sort_custom(
		func(target_a: TargetableManager, target_b: TargetableManager): 
			return target_a.priority > target_b.priority
	)
	## select target with maximum priority
	return InstanceHelper.targets[0]
