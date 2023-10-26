class_name AxeAbility extends Node2D

@export var max_radius = 100

@onready var player = get_tree().get_first_node_in_group("player") as Player

@onready var hitbox_component: Area2D = $HitboxComponent

var base_rotation = Vector2.RIGHT

func _ready() -> void:
	randomize()
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 2.0, 2.5)
	tween.tween_callback(queue_free)


func tween_method(rotations: float) -> void:
	if not player: return
	
	var percent = rotations / 2
	var current_radius = percent * max_radius
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	global_position = player.global_position + (current_direction * current_radius) 
