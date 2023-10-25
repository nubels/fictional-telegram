class_name RatEnemy extends CharacterBody2D

@export var max_speed = 40
@export var health_component: HealthComponent

# eigentlich ganz cool für dependencies oder?
@onready var player = get_tree().get_first_node_in_group("player") as Player


func _process(delta: float) -> void:
	move_towards_player()


func move_towards_player() -> void:
	if not player: return
	
	var direction := global_position.direction_to(player.global_position)
	
	velocity = direction * max_speed
	
	move_and_slide()
