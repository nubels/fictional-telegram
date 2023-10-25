class_name HurtboxComponent extends Area2D

@export var health_component: HealthComponent


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	if not health_component: return
	
	if not other_area is HitboxComponent: return
	
	health_component.take_damage(other_area.damage)
