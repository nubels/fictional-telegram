class_name UpgradeManager extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_sceen_scene: PackedScene

var current_upgrades = {}


func _ready() -> void:
	experience_manager.leveled_up.connect(on_level_up)


func apply_upgrade(chosen_upgrade: AbilityUpgrade) -> void:
	
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	
	if not has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			ressource = chosen_upgrade,
			quantity = 1
		}
	else:
		current_upgrades[chosen_upgrade.id].quantity += 1
	
	if chosen_upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[chosen_upgrade.id].quantity
		if current_quantity == chosen_upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func(pool_upgrade): return pool_upgrade.id != chosen_upgrade.id)
	
	
	GameEvents.emit_ability_upgrade_added(chosen_upgrade, current_upgrades)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filtered_upgrades = upgrade_pool.duplicate()
	
	for i in 2:
		if filtered_upgrades.size() == 0: break
		
		var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		
		chosen_upgrades.append(chosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(func(upgrade):
			return upgrade.id != chosen_upgrade.id
		)
	
	return chosen_upgrades


func on_level_up(current_level: int) -> void:
	var chosen_upgrades = pick_upgrades()
	
	var upgrade_sceen_instance = upgrade_sceen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_sceen_instance)
	upgrade_sceen_instance.set_ability_upgrades(chosen_upgrades)
	upgrade_sceen_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
