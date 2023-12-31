extends Node


signal experience_vial_collected(number: float)

func emit_experience_vial_collected(number: float) -> void:
	experience_vial_collected.emit(number)


signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)

func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	ability_upgrade_added.emit(upgrade, current_upgrades)
