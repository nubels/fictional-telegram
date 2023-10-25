class_name Player extends CharacterBody2D


@export var max_speed := 150
@export var acceleration_smoothing := 25

@export var health_component: HealthComponent

@onready var collision_area: Area2D = $CollisionArea2D
@onready var damage_interval_timer: Timer = $DamageIntervalTimer

var number_colliding_bodies: int

func _ready() -> void:
	collision_area.body_entered.connect(on_body_entered)
	collision_area.body_exited.connect(on_body_exited)
	
	damage_interval_timer.timeout.connect(on_damager_interval_timer)


func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target_velocity = input_vector * max_speed
	
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta * acceleration_smoothing))
	
	
	
	move_and_slide()


func check_deal_damage() -> void:
	if number_colliding_bodies == 0 or not damage_interval_timer.is_stopped(): return
	
	health_component.take_damage(1)
	damage_interval_timer.start()
	
	print(health_component.current_health)



func on_body_entered(other_body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D) -> void:
	number_colliding_bodies -= 1


func on_damager_interval_timer() -> void:
	check_deal_damage()
