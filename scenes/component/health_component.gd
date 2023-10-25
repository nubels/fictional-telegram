class_name HealthComponent extends Node

@export var max_health: float = 10

@onready var current_health = max_health

signal health_depleted


func take_damage(damage_amount: float) -> void:
	current_health = max(current_health - damage_amount, 0)
	
	Callable(check_death).call_deferred()


func check_death() -> void:
	if current_health == 0:
		health_depleted.emit()
		owner.queue_free()
