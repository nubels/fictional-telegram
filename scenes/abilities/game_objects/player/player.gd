class_name Player extends CharacterBody2D


@export var max_speed := 150
@export var acceleration_smoothing := 25


func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target_velocity = input_vector * max_speed
	
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta * acceleration_smoothing))
	
	
	
	move_and_slide()
