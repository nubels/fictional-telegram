class_name Player extends CharacterBody2D


@export var max_speed = 200


func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_vector * max_speed
	
	move_and_slide()
