class_name UpgradeManager extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_sceen_scene: PackedScene

var current_upgrades = {}


func _ready() -> void:
	experience_manager.leveled_up.connect(on_level_up)


func on_level_up(current_level: int) -> void:
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	
	if not chosen_upgrade: return
	
	var upgrade_sceen_instance = upgrade_sceen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_sceen_instance)
	upgrade_sceen_instance.set_ability_upgrades([chosen_upgrade])
	upgrade_sceen_instance.upgrade_selected.connect(on_upgrade_selected)


func apply_upgrade(chosen_upgrade: AbilityUpgrade) -> void:
	
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	
	if not has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			ressource = chosen_upgrade,
			quantity = 1
		}
	else:
		current_upgrades[chosen_upgrade.id].quantity += 1
	
	GameEvents.emit_ability_upgrade_added(chosen_upgrade, current_upgrades)


func on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
