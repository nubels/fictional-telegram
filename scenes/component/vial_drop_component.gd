class_name VialDropComponent extends Node

@export_range(0, 1) var drop_percent: float = .5
@export var vial_scene: PackedScene
@export var health_component: HealthComponent

@onready var entities_layer = get_tree().get_first_node_in_group("entities_layer") as Node2D


func _ready() -> void:
	health_component.health_depleted.connect(on_health_component_health_depleted)


func on_health_component_health_depleted() -> void:
	if randf() > drop_percent: return
	
	if not vial_scene: return
	
	if not owner is Node2D: return
	
	var spawn_position = (owner as Node2D).global_position
	
	var vial_instance = vial_scene.instantiate() as Node2D
	
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
