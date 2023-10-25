class_name ExperienceVial extends Node2D

@onready var pickup_area: Area2D = $PickupArea


func _ready() -> void:
	pickup_area.area_entered.connect(on_pickup_area_entered)


func on_pickup_area_entered(other_area: Area2D) -> void:
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
