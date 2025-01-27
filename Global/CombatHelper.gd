#CombatHelper
extends Node


func damage_area_entered(damage: int, area: Area2D) -> bool:
	#NOTE: this rely on each enemy having at most 1 area2d, which is a hit box
	#need to add group tag to area if it has non-hitbox area
	var area_owner = area.owner
	if area_owner is Enemy:
		if area_owner.is_queued_for_deletion():
			return false
		area_owner.take_damage(damage, self)
		return true
	else:
		return false

func select_target(position: Vector2) -> TargetableManager:
	# sort the whole array to get the minimum because lazy and can't find custom_min
	var max_priority = InstanceHelper.targets.map(func(target: TargetableManager): return target.priority).max()
	var max_priority_targets = InstanceHelper.targets.filter(func(target: TargetableManager): return target.priority == max_priority)
	var min_distance: float = INF
	var min_distance_target: TargetableManager
	for target: TargetableManager in max_priority_targets:
		var distance = (position - target.position_getter.call()).length()
		if  distance < min_distance:
			min_distance_target = target
			min_distance = distance
	#InstanceHelper.targets.sort_custom(
		#func(target_a: TargetableManager, target_b: TargetableManager): 
			#return target_a.priority > target_b.priority
	#)
	## select target with maximum priority
	#return InstanceHelper.targets[0]
	return min_distance_target
