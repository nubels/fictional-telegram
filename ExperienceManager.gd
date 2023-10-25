class_name ExperienceManager extends Node

var current_experience = 0


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(number: float) -> void:
	current_experience += number


func on_experience_vial_collected(number: float) -> void:
	increment_experience(number)
